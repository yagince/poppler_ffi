require 'ffi'
require 'poppler/binding'
require 'poppler/rectangle'

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

    def crop_box
      crop_box = Rectangle.new
      Binding.poppler_page_get_crop_box(self.to_ptr, crop_box)
      crop_box
    end

    def duration
      Binding.poppler_page_get_duration(self.to_ptr)
    end
  end
end
