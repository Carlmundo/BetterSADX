SADX Keyboard Remapper by PkR

This mod lets you change keyboard controls in Sonic Adventure DX PC (2004).
To change keyboard keys, use either ConfigTool.exe in the mod folder or the Mod Manager's mod configuration dialog. You can also edit config.ini manually. The file keys.txt contains a list of available keys.
Starting with version 2.2 the mod also allows to map the controller's Z button, which is sometimes used in mods.
Starting with version 2.3 the mod allows to map the controller's C and D buttons (unused in SADX).

Information for speedrunners:
In the default configuration (alternative layouts for Keys 2 and 3 disabled) the mod is 100% speedrun friendly. It changes key binds directly without altering SADX input routines, so it does not add any delays to input recognition (except "center camera" and controller's Z button, which are checked outside of the vanilla input routine). 
When alternative layouts are enabled, the mod maps SADX keyboard keys to a set of virtual keys, for which keypresses are detected in the Mod Loader's OnInput function. This still uses vanilla SADX input routines for actual movement, but keypress detection may (or may not) be delayed for up to one frame.
To ensure 100% vanilla behavior, disable the option "AlternativeLayouts" in the mod's config or uncheck "Enable Keys 2 and 3" in the config tool.

Using the config tool:
Click the keybind you want to change and press the desired key. Right click on a keybind to clear the binding.

Known issues:
-This mod is not compatible with the Input Mod. Please disable or remove this mod if you use the Input Mod.
-Up and Down on the D-Pad are swapped when using the Smooth Camera mod.
-Some keys are not detected by vanilla SADX so they are not mappable and will be displayed as "None" in the config tool.

Version history

2.31
The mod should now parse key name strings with an extra space correctly

2.3
The mod now terminates itself when the Input mod is detected
Added support for C and D buttons (config file only)
The "General" section in the config file has been renamed to "Config"
Config schema and the config tool have been updated for the above change

2.22
Config tool: actions mapped to each key/button are now highlighted when mouse cursor is over their keybinds
Config tool: added a dark overlay for Key 2 and 3 bindings when Keys 2 and 3 are disabled

2.21
Updated config tool GUI

2.2
Updated config tool GUI
Added an option to map the rarely used controller Z button
Added details on speedrunning with this mod

2.1
When alternative layouts are disabled, the mod doesn't hijack the game's input code (except the E key), which makes it frame accurate to vanilla SADX - this might be helpful for speedrunning
Updated config tool to prevent false positives with some anti-virus software

2.0
Added a new tool to configure keys
Added an option to disable mouse input
Added two alternative keyboard layouts
Updated the list of available keys

1.0
Initial release