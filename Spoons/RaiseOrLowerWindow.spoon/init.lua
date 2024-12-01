-- Raise or Lower Window under the mouse position

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "RaiseOrLowerWindow"
obj.version = "1.0"
obj.author = "Tilo Sloboda <tilo@unixgods.org>"
obj.homepage = "https://github.com/yourusername/WindowControl.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Configuration variables
obj.hotkeys = {}
obj.mouseButton = 4  -- Default mouse button number
obj.bindHotkeys = true
obj.bindMouse = true

-- Internal function to lower the current window
function obj:lowerWindowUnderMouse()
    local currentWindow = hs.window.focusedWindow()
    if currentWindow then
        currentWindow:sendToBack()
    end
end

-- Function to bind hotkeys and mouse events
function obj:start()
    if self.bindHotkeys and self.hotkeys then
        for _, keyCombo in ipairs(self.hotkeys) do
            hs.hotkey.bind(keyCombo.mods, keyCombo.key, function()
                self:lowerWindowUnderMouse()
            end)
        end
    end

    if self.bindMouse then
        self.mouseTap = hs.eventtap.new({hs.eventtap.event.types.otherMouseDown}, function(event)
            local buttonNumber = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)
            if buttonNumber == self.mouseButton then
                self:lowerWindowUnderMouse()
                return true
            end
        end)
        self.mouseTap:start()
    end
end

-- Function to stop the spoon
function obj:stop()
    if self.mouseTap then
        self.mouseTap:stop()
        self.mouseTap = nil
    end
end

return obj
