require 'ffi'

module Poppler
  class Page < FFI::Struct
    layout :label, :string
  end
end
