require 'ffi'
require 'uri'

require 'poppler_ffi/binding'
require 'poppler_ffi/permissions'
require 'poppler_ffi/page'

module PopplerFFI
  class Document < FFI::Struct
    layout :author, :string,
           :creation_date, :int,
           :creator, :string,
           :format, :string,
           :metadata, :string,
           :subject, :string,
           :title, :string

    def initialize(file, password=nil)
      error = GError.new
      file = ensure_uri(file)
      @ptr = Binding.poppler_document_new_from_file(file, password, error.to_ptr)
      raise error[:message] if !error.null? && !error[:message].nil? && !error[:message].empty?
      super(@ptr)
    end

    def pdf_version
      Binding.poppler_document_get_pdf_version_string(self.to_ptr)
    end

    def author
      Binding.poppler_document_get_author(self.to_ptr)
    end

    def title
      Binding.poppler_document_get_title(self.to_ptr)
    end

    def subject
      Binding.poppler_document_get_subject(self.to_ptr)
    end

    def keywords
      Binding.poppler_document_get_keywords(self.to_ptr)
    end

    def created_date
      epoch = Binding.poppler_document_get_creation_date(self.to_ptr)
      Time.at(epoch)
    end

    def updated_date
      epoch = Binding.poppler_document_get_modification_date(self.to_ptr)
      Time.at(epoch)
    end

    def page_layout
      Binding.poppler_document_get_page_layout(self.to_ptr)
    end

    def page_count
      Binding.poppler_document_get_n_pages(self.to_ptr)
    end

    def pages
      (1..(page_count)).map{|i|
        PopplerFFI::Page.new(Binding.poppler_document_get_page(self.to_ptr, i-1))
      }
    end

    def page_mode
      Binding.poppler_document_get_page_mode(self.to_ptr)
    end

    def permissions
      PopplerFFI::Permissions.new(Binding.poppler_document_get_permissions(self.to_ptr))
    end

    private

    def pdf_data?(data)
      /\A%PDF-1\.\d/ =~ data
    end

    def ensure_uri(uri)
      if pdf_data?(uri)
        @pdf = Tempfile.new("ruby-poppler-pdf")
        @pdf.binmode
        @pdf.print(uri)
        @pdf.close
        uri = @pdf.path
      end

      return uri if /\A[a-zA-Z][a-zA-Z\d\-+.]*:/.match(uri)
      URI.join('file:///', File.expand_path(uri)).to_s
    end
  end
end
