module PopplerFFI
  module Enum
    extend FFI::Library

    PageLayout = enum(
      :unset,            # no specific layout set
      :single_page,      # one page at a time
      :one_column,       # pages in one column
      :two_column_left,  # pages in two columns with odd numbered pages on the left
      :two_column_right, # pages in two columns with odd numbered pages on the right
      :two_page_left,    # two pages at a time with odd numbered pages on the left
      :two_page_right    # two pages at a time with odd numbered pages on the right
    )

    PageMode = enum(
      :unset,          # no specific mode set
      :none,           # neither document outline nor thumbnails visible
      :use_outlines,   # document outline visible
      :use_thumbs,     # thumbnails visible
      :full_screen,    # full-screen mode
      :use_oc,         # layers panel visible
      :use_attachments # attachments panel visible
    )
  end
end
