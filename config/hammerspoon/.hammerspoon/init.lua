hs.ipc.cliInstall()

local hs = hs
POINTER = nil
POINTER_LIFETIME = nil

local function mouseHighlight()
  -- Delete an existing highlight if it exists
  if POINTER then
    POINTER:delete()
    if POINTER_LIFETIME then
      POINTER_LIFETIME:stop()
    end
  end

  -- Get the current co-ordinates of the mouse pointer
  local mousepoint = hs.mouse.absolutePosition()

  -- Prepare a big red circle around the mouse pointer
  local radius = 20
  POINTER = hs.drawing.circle(hs.geometry.rect(
    mousepoint.x - radius, mousepoint.y - radius, radius * 2, radius * 2))
  POINTER:setStrokeColor({ ["red"] = 255, ["blue"] = 40, ["green"] = 0, ["alpha"] = 0.9 })
  POINTER:setFill(false)
  POINTER:setStrokeWidth(5)
  POINTER:show()

  -- Set a timer to delete the circle after 3 seconds
  POINTER_LIFETIME = hs.timer.doAfter(3, function()
    POINTER:delete()
    POINTER = nil
  end)
end

hs.hotkey.bind({ "alt" }, "q", mouseHighlight)

-- ========================
-- Stackline

local stackline = require "stackline"
stackline:init()
