$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'poppler_ffi'
require 'gir_ffi-cairo'

RSpec.configure do |config|
  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true unless meta.key?(:aggregate_failures)
  end
end
