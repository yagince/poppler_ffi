require 'ffi'
require "glib2"
require 'open3'

module Poppler
  module DocumentBinding
    extend FFI::Library

    # TODO: support windows
    def self.find_library
      if RbConfig::CONFIG['host_os'] =~ /darwin/i
        ext = 'dylib'
      else
        ext = 'so'
      end

      "libpoppler-glib.#{ext}"
    end

    ffi_lib find_library

    attach_function :poppler_document_new_from_file, [:string, :string, :pointer], :pointer
    attach_function :poppler_document_get_pdf_version_string, [:pointer], :string
    attach_function :poppler_document_get_title, [:pointer], :string
    attach_function :poppler_document_get_author, [:pointer], :string
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

    def title
      DocumentBinding.poppler_document_get_title(self.to_ptr)
    end

    def author
      DocumentBinding.poppler_document_get_author(self.to_ptr)
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
