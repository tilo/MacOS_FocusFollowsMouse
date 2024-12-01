-- ~/.hammerspoon/Spoons/NewWindowAtMouse.spoon/init.lua

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "NewWindowAtMouse"
obj.version = "1.0"
obj.author = "Your Name <you@example.com>"
obj.homepage = "https://github.com/yourusername/NewWindowAtMouse.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Configuration variables
obj.enabled = true
obj.desktopSwitchDelay = 2.5  -- Delay to re-enable after desktop switch

-- Internal variables
obj.desktopSwitching = false

function obj:moveAndRaiseWindowToMouse(window)
    if not self.enabled or self.desktopSwitching then return end

    if window then
        local mousePoint = hs.mouse.absolutePosition()
        local windowSize = window:size()
        local newTopLeft = {
            x = mousePoint.x - (windowSize.w / 2),
            y = mousePoint.y - (windowSize.h / 2)
        }
        window:setTopLeft(newTopLeft)
        window:focus()
        window:raise()
    end
end

function obj:start()
    -- Watch for new windows
    self.windowFilter = hs.window.filter.new(nil)
    self.windowFilter:subscribe(hs.window.filter.windowCreated, function(window, appName)
        self:moveAndRaiseWindowToMouse(window)
    end)

    -- Desktop switch detection
    self.spaceWatcher = hs.spaces.watcher.new(function()
        if self.enabled then
            self.enabled = false
            self.desktopSwitching = true

            hs.timer.doAfter(self.desktopSwitchDelay, function()
                self.desktopSwitching = false
                self.enabled = true
            end)
        end
    end)
    self.spaceWatcher:start()
end

function obj:stop()
    if self.windowFilter then
        self.windowFilter:unsubscribeAll()
        self.windowFilter = nil
    end
    if self.spaceWatcher then
        self.spaceWatcher:stop()
        self.spaceWatcher = nil
    end
end

return obj
