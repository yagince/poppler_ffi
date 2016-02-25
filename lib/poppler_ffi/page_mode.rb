module PopplerFFI
  class PageMode
    POPPLER_PAGE_MODE_UNSET           = 0
    POPPLER_PAGE_MODE_NONE            = 1
    POPPLER_PAGE_MODE_USE_OUTLINES    = 2
    POPPLER_PAGE_MODE_USE_THUMBS      = 3
    POPPLER_PAGE_MODE_FULL_SCREEN     = 4
    POPPLER_PAGE_MODE_USE_OC          = 5
    POPPLER_PAGE_MODE_USE_ATTACHMENTS = 6

    def initialize(mode)
      @mode = mode
    end
  end
end
