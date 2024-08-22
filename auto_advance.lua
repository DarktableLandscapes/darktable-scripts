local dt = require "darktable"

-- Variable to control whether auto-advance is enabled
local auto_advance_enabled = true -- Set this to true if you want auto-advance enabled by default

-- Function to move to the next image
local function move_to_next_image()
  local images = dt.gui.selection()
  if #images > 0 then
    dt.gui.action("lighttable|next")
  end
end

-- Function that handles rating or rejecting and moves to the next image if auto-advance is enabled
local function on_keypress_rating_or_reject(event, key, modifiers)
  if auto_advance_enabled then
    -- Check if the key press is a rating (1 to 5) or rejection (r)
    if key >= 49 and key <= 53 then -- Keys '1' to '5' for rating
      move_to_next_image()
    elseif key == 114 then -- Key 'r' for reject
      move_to_next_image()
    end
  end
end

-- Function to toggle auto-advance on or off
local function toggle_auto_advance()
  auto_advance_enabled = not auto_advance_enabled
  if auto_advance_enabled then
    dt.print("Auto-advance enabled")
  else
    dt.print("Auto-advance disabled")
  end
end

-- Register a shortcut to toggle auto-advance
dt.register_event("shortcut", "toggle_auto_advance", toggle_auto_advance)

-- Register a keyboard event to listen for rating and rejection keys
dt.register_event("key-pressed", on_keypress_rating_or_reject)

-- Notify that the script has been loaded
dt.print("Auto-advance script loaded! Use the shortcut to toggle auto-advance.")
