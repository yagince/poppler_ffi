module PopplerFFI
  class Util
    # TODO: support windows
    def self.find_library
      if RbConfig::CONFIG['host_os'] =~ /darwin/i
        ext = 'dylib'
      else
        ext = 'so'
      end

      "libpoppler-glib.#{ext}"
    end
  end
end
