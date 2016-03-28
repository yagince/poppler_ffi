require 'poppler_ffi/enum'

module PopplerFFI
  module Binding
    extend FFI::Library
    extend PopplerFFI::Enum

    ffi_lib PopplerFFI::Util.find_library

    # Document
    attach_function :poppler_document_new_from_file, [:string, :string, :pointer], :pointer
    attach_function :poppler_document_new_from_data, [:pointer, :int, :string, :pointer], :pointer
    attach_function :poppler_document_get_pdf_version_string, [:pointer], :string
    attach_function :poppler_document_get_title, [:pointer], :string
    attach_function :poppler_document_get_author, [:pointer], :string
    attach_function :poppler_document_get_subject, [:pointer], :string
    attach_function :poppler_document_get_keywords, [:pointer], :string
    attach_function :poppler_document_get_creation_date, [:pointer], :int
    attach_function :poppler_document_get_modification_date, [:pointer], :int
    attach_function :poppler_document_get_page_layout, [:pointer], PopplerFFI::Enum::PageLayout
    attach_function :poppler_document_get_n_pages, [:pointer], :int
    attach_function :poppler_document_get_page, [:pointer, :int], :pointer
    attach_function :poppler_document_get_page_mode, [:pointer], PopplerFFI::Enum::PageMode
    attach_function :poppler_document_get_permissions, [:pointer], :int

    # Page
    attach_function :poppler_page_get_index, [:pointer], :int
    attach_function :poppler_page_get_label, [:pointer], :string
    attach_function :poppler_page_get_size, [:pointer, :pointer, :pointer], :void
    attach_function :poppler_page_get_thumbnail_size, [:pointer, :pointer, :pointer], :void
    attach_function :poppler_page_get_crop_box, [:pointer, :pointer], :void
    attach_function :poppler_page_get_duration, [:pointer], :double
    attach_function :poppler_page_get_text, [:pointer], :string
    attach_function :poppler_page_get_text_for_area, [:pointer, :pointer], :string
    attach_function :poppler_page_get_text_layout, [:pointer, :pointer, :pointer], :bool
    attach_function :poppler_page_render, [:pointer, :pointer], :void

    # Rectangle
    attach_function :poppler_rectangle_free, [:pointer], :void
  end
end
