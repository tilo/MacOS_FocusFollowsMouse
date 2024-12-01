-- ~/.hammerspoon/Spoons/FocusUnderMouse.spoon/init.lua

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "FocusUnderMouse"
obj.version = "1.0"
obj.author = "Your Name <you@example.com>"
obj.homepage = "https://github.com/yourusername/FocusUnderMouse.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Configuration variables
obj.delay = 0.25
obj.enabled = true

-- Internal variables
obj.focusTimer = nil

function obj:checkMouseMovement()
    if not self.enabled then return end

    if self.focusTimer then
        self.focusTimer:stop()
    end

    self.focusTimer = hs.timer.doAfter(self.delay, function()
        local mousePoint = hs.mouse.absolutePosition()
        local orderedWindows = hs.window.orderedWindows()

        for _, window in ipairs(orderedWindows) do
            if hs.geometry(mousePoint):inside(window:frame()) then
                window:focus() -- will raise the window, instead try becomeMain()
                break
            end
        end
    end)
end

function obj:start()
    self.mouseWatcher = hs.eventtap.new({hs.eventtap.event.types.mouseMoved}, function(event)
        self:checkMouseMovement()
        return false
    end)
    self.mouseWatcher:start()
end

function obj:stop()
    if self.mouseWatcher then
        self.mouseWatcher:stop()
        self.mouseWatcher = nil
    end
end

return obj
