
-- Configuration Section
local config = {
    raiseOrLowerWindow = {
        hotkeys = {
            {mods = {"cmd", "ctrl"}, key = "L"},
            -- Add more key bindings if needed
        },
        mouseButton = 4,
        bindHotkeys = true,
        bindMouse = true,
    },
    autoRaiseWindow = {
        delay = 0.25,
        enabled = false,  -- Disable this feature
    },
    focusUnderMouse = {
        delay = 0.25,
        enabled = true,
    },
    newWindowAtMouse = {
        enabled = true,
        desktopSwitchDelay = 30,
    },
}

-- Load and Configure RaiseOrLowerWindow Spoon
hs.loadSpoon("RaiseOrLowerWindow")
spoon.RaiseOrLowerWindow.hotkeys = config.raiseOrLowerWindow.hotkeys
spoon.RaiseOrLowerWindow.mouseButton = config.raiseOrLowerWindow.mouseButton
spoon.RaiseOrLowerWindow.bindHotkeys = config.raiseOrLowerWindow.bindHotkeys
spoon.RaiseOrLowerWindow.bindMouse = config.raiseOrLowerWindow.bindMouse
spoon.RaiseOrLowerWindow:start()

-- Load and Configure AutoRaiseWindow Spoon
hs.loadSpoon("AutoRaiseWindow")
spoon.AutoRaiseWindow.delay = config.autoRaiseWindow.delay
spoon.AutoRaiseWindow.enabled = config.autoRaiseWindow.enabled
if spoon.AutoRaiseWindow.enabled then
    spoon.AutoRaiseWindow:start()
end

-- Load and Configure FocusUnderMouse Spoon
hs.loadSpoon("FocusUnderMouse")
spoon.FocusUnderMouse.delay = config.focusUnderMouse.delay
spoon.FocusUnderMouse.enabled = config.focusUnderMouse.enabled
if spoon.FocusUnderMouse.enabled then
    spoon.FocusUnderMouse:start()
end

-- Load and Configure NewWindowAtMouse Spoon
hs.loadSpoon("NewWindowAtMouse")
spoon.NewWindowAtMouse.enabled = config.newWindowAtMouse.enabled
spoon.NewWindowAtMouse.desktopSwitchDelay = config.newWindowAtMouse.desktopSwitchDelay
if spoon.NewWindowAtMouse.enabled then
    spoon.NewWindowAtMouse:start()
end


-- ------------------------------------------------------------------------
-- Automatically reload Hammerspoon when this config file is changed
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            hs.reload()
        end
    end
end):start()

-- Show a notification when the config is reloaded
hs.alert.show("Hammerspoon config reloaded automatically")

