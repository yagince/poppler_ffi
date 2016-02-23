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
  end
end
