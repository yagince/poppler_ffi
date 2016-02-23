require 'ffi'
require 'poppler/binding'

module Poppler
  class Page < FFI::Struct
    layout :label, :string

    def index
      Binding.poppler_page_get_index(self.to_ptr)
    end

    def label
      Binding.poppler_page_get_label(self.to_ptr)
    end

    def page_size
      width_ptr = FFI::MemoryPointer.new :double
      height_ptr = FFI::MemoryPointer.new :double
      Binding.poppler_page_get_size(self.to_ptr, width_ptr, height_ptr)
      { width: width_ptr.read_double, height: height_ptr.read_double }
    end
  end
end
