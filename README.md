# Focus Follows Mouse for MacOS

Still experimental -- pull requests welcome! ❤️

## Installation

* install [Hammerspoon](https://www.hammerspoon.org/go/)
* in your homedirectory create a directory `./hammerspoon`
* copy the `Spoons` directory and the `init.lua` file to `./hammerspoon`
* restart Hammerspoon

## Why? / Background

Back in the days, FVWM was an awesome window manager that was able to manage multiple desktops on multiple monitors, and had an easy way to move windows between desktops or monitors.

One of the main features was that the user can control these behaviors independently:

* focus follows mouse : brings the window under the mouse in focus, but does not raise it.
  -> partially obscured windows were able to receive input from the keyboard
* binding "raise or lower window" to a key
  -> allowing to either bring the window under the mouse all the way to the front, or all the way to the back. 
     This made it very easy to shuffle the windows on the screen.
* new windows would **always** be opened where the mouse is
  -> Why would you not want to immediately interact with your new window?

Today's MacOS is very opinionated, and is forcing the users to do window management the "Apple Way" -- which probably works well if you only have one screen, but for power users with multiple screens it can be challenging: Windows appear on random screens, or even on another desktop.. Windows have to be on top to receive keyboard input (iTerm2 tries to work around this, but there is not general way to do this in MacOS for all windows).

