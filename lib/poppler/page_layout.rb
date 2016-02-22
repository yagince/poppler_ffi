module Poppler
  class PageLayout
    POPPLER_PAGE_LAYOUT_UNSET            = 0
    POPPLER_PAGE_LAYOUT_SINGLE_PAGE      = 1
    POPPLER_PAGE_LAYOUT_ONE_COLUMN       = 2
    POPPLER_PAGE_LAYOUT_TWO_COLUMN_LEFT  = 3
    POPPLER_PAGE_LAYOUT_TWO_COLUMN_RIGHT = 4
    POPPLER_PAGE_LAYOUT_TWO_PAGE_LEFT    = 5
    POPPLER_PAGE_LAYOUT_TWO_PAGE_RIGHT   = 6

    def initialize(layout)
      @layout = layout
    end
  end
end
