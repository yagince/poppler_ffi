require 'ffi'
require "glib2"
require 'open3'

require 'poppler/page_layout'
require 'poppler/page_mode'
require 'poppler/page'

module Poppler
  module DocumentBinding
    extend FFI::Library

    ffi_lib Poppler::Util.find_library

    attach_function :poppler_document_new_from_file, [:string, :string, :pointer], :pointer
    attach_function :poppler_document_get_pdf_version_string, [:pointer], :string
    attach_function :poppler_document_get_title, [:pointer], :string
    attach_function :poppler_document_get_author, [:pointer], :string
    attach_function :poppler_document_get_subject, [:pointer], :string
    attach_function :poppler_document_get_keywords, [:pointer], :string
    attach_function :poppler_document_get_creation_date, [:pointer], :int
    attach_function :poppler_document_get_modification_date, [:pointer], :int
    attach_function :poppler_document_get_page_layout, [:pointer], :int
    attach_function :poppler_document_get_n_pages, [:pointer], :int
    attach_function :poppler_document_get_page, [:pointer, :int], :pointer
    attach_function :poppler_document_get_page_mode, [:pointer], :int
  end

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
      @ptr = DocumentBinding.poppler_document_new_from_file(file, password, error.to_ptr)
      raise error[:message] if !error.null? && !error[:message].nil? && !error[:message].empty?
      super(@ptr)
    end

    def pdf_version
      DocumentBinding.poppler_document_get_pdf_version_string(self.to_ptr)
    end

    def author
      DocumentBinding.poppler_document_get_author(self.to_ptr)
    end

    def title
      DocumentBinding.poppler_document_get_title(self.to_ptr)
    end

    def subject
      DocumentBinding.poppler_document_get_subject(self.to_ptr)
    end

    def keywords
      DocumentBinding.poppler_document_get_keywords(self.to_ptr)
    end

    def created_date
      epoch = DocumentBinding.poppler_document_get_creation_date(self.to_ptr)
      Time.at(epoch)
    end

    def updated_date
      epoch = DocumentBinding.poppler_document_get_modification_date(self.to_ptr)
      Time.at(epoch)
    end

    def page_layout
      PageLayout.new(DocumentBinding.poppler_document_get_page_layout(self.to_ptr))
    end

    def page_count
      DocumentBinding.poppler_document_get_n_pages(self.to_ptr)
    end

    def pages
      (1..(page_count)).map{|i|
        Poppler::Page.new(DocumentBinding.poppler_document_get_page(self.to_ptr, i-1))
      }
    end

    def page_mode
      Poppler::PageMode.new(DocumentBinding.poppler_document_get_page_mode(self.to_ptr))
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

      if GLib.path_is_absolute?(uri)
        GLib.filename_to_uri(uri)
      elsif /\A[a-zA-Z][a-zA-Z\d\-+.]*:/.match(uri)
        uri
      else
        GLib.filename_to_uri(File.expand_path(uri))
      end
    end
  end
end
