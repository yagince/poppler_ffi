require 'ffi'
require 'poppler/binding'
require 'poppler/rectangle'
require 'poppler/libc'

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

    def text(area_rectangle = nil)
      if area_rectangle
        Binding.poppler_page_get_text_for_area(self.to_ptr, area_rectangle)
      else
        @text ||= Binding.poppler_page_get_text(self.to_ptr)
      end
    end

    def text_layout
      array_ptr = FFI::MemoryPointer.new :pointer
      count_ptr = FFI::MemoryPointer.new :int
      unless Binding.poppler_page_get_text_layout(self.to_ptr, array_ptr, count_ptr)
        return []
      end

      n = count_ptr.read_uint
      array = array_ptr.read_pointer
      p array.size
      rectangles = n.times.map{|i| Rectangle.new(array[i].read_pointer) }
      # rectangles = array.read_array_of_pointer(n).map{|ptr|
      #   p ptr
      #   Rectangle.new(ptr.read_pointer)
      # }
      rectangles
    end
  end
end
