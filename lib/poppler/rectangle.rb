require 'ffi'

module Poppler
  class Rectangle < FFI::Struct
    layout :x1, :double,
           :y1, :double,
           :x2, :double,
           :y2, :double

    %i(x1 y1 x2 y2).each do |name|
      define_method(name) do
        self[name]
      end
    end
  end
end
