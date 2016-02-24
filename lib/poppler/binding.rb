module Poppler
  module Binding
    extend FFI::Library

    ffi_lib Poppler::Util.find_library

    # Document
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
    attach_function :poppler_document_get_permissions, [:pointer], :int

    # Page
    attach_function :poppler_page_get_index, [:pointer], :int
    attach_function :poppler_page_get_label, [:pointer], :string
    attach_function :poppler_page_get_size, [:pointer, :pointer, :pointer], :void
    attach_function :poppler_page_get_crop_box, [:pointer, :pointer], :void
    attach_function :poppler_page_get_duration, [:pointer], :double
  end
end
