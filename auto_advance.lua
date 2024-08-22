local dt = require "darktable"

-- Variable to control whether auto-advance is enabled
local auto_advance_enabled = false

-- Function to move to the next image
local function move_to_next_image()
  local images = dt.gui.selection()
  if #images > 0 then
    dt.gui.action("lighttable|next")
  end
end

-- Function that triggers when a rating is applied or an image is rejected
local function on_image_rating_or_reject_change(event, image)
  if auto_advance_enabled then
    local rating = image.rating
    if rating >= 0 or rating == -1 then -- -1 is for reject, 0-5 are valid ratings
      move_to_next_image()
    end
  end
end

-- Toggle auto-advance on or off
local function toggle_auto_advance()
  auto_advance_enabled = not auto_advance_enabled
  if auto_advance_enabled then
    dt.print("Auto-advance enabled")
  else
    dt.print("Auto-advance disabled")
  end
end

-- Register the event that listens for rating changes (including reject)
dt.register_event("auto_advance_on_rating_or_reject", "rate_change", on_image_rating_or_reject_change)

-- Register a shortcut to toggle auto-advance
dt.register_event("toggle_auto_advance", "shortcut", toggle_auto_advance)

-- Notify that the script has been loaded
dt.print("Auto-advance script loaded! Use the shortcut to toggle auto-advance.")
