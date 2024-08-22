-- Import Darktable Lua API
local dt = require "darktable"

-- Store the last known rating for the currently viewed image
local last_rating = nil

-- Function to auto-advance when the rating changes
local function check_rating_change()
  -- Get the currently selected image
  local current_image = dt.gui.action_images.get_current()

  if current_image then
    -- Check if the rating has changed
    if last_rating ~= current_image.rating then
      last_rating = current_image.rating
     
        dt.gui.action_images.next()
      
    end
  end
end

-- Register the timer to periodically check for rating changes
dt.register_event("post-export", function()
  dt.gui.libs.ratings.connect_signal("changed", check_rating_change)
end)
