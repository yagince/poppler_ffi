require 'ffi'
require 'poppler_ffi/binding'
require 'poppler_ffi/rectangle'
require 'poppler_ffi/libc'
require 'poppler_ffi/glib'

module PopplerFFI
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

    def thumbnail_size
      width_ptr = FFI::MemoryPointer.new :double
      height_ptr = FFI::MemoryPointer.new :double
      Binding.poppler_page_get_thumbnail_size(self.to_ptr, width_ptr, height_ptr)
      { width: width_ptr.read_double, height: height_ptr.read_double }
    end

    def crop_box
      crop_box = RectangleFFI.new
      Binding.poppler_page_get_crop_box(self.to_ptr, crop_box)
      r = crop_box.to_rectangle!
      GLib.g_free(crop_box)
      r
    end

    def duration
      Binding.poppler_page_get_duration(self.to_ptr)
    end

    def text(area_rectangle = nil)
      if area_rectangle
        Binding.poppler_page_get_text_for_area(self.to_ptr, area_rectangle.to_ffi).force_encoding('UTF-8')
      else
        @text ||= Binding.poppler_page_get_text(self.to_ptr).force_encoding('UTF-8')
      end
    end

    def text_layout
      array_ptr = FFI::MemoryPointer.new RectangleFFI
      count_ptr = FFI::MemoryPointer.new :int
      unless Binding.poppler_page_get_text_layout(self.to_ptr, array_ptr, count_ptr)
        return []
      end

      n = count_ptr.read_uint
      array = array_ptr.read_pointer
      rectangles = n.times.map { |i|
        RectangleFFI.new(array[i * RectangleFFI.size]).to_rectangle!
      }
      GLib.g_free(array)
      rectangles
    end

    def render(cairo_context)
      Binding.poppler_page_render(self.to_ptr, cairo_context.to_ptr)
    end
  end
end
