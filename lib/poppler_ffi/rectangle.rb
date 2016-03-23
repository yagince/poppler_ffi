require 'ffi'

module PopplerFFI
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

    def ==(other)
      other.respond_to?(:x1) &&
        other.respond_to?(:y1) &&
        other.respond_to?(:x2) &&
        other.respond_to?(:y2) &&
        other.x1 == x1 &&
        other.y1 == y1 &&
        other.x2 == x2 &&
        other.y2 == y2
    end
  end
end
