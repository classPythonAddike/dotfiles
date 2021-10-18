from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

import os, subprocess

mod = "mod4"
terminal = "alacritty"

window_padding = 6

colors = {
    "nord_dark_blue_0": "#2E3440",
    "nord_dark_blue_1": "#3B4252",
    "nord_dark_blue_2": "#434C5E",
    "nord_dark_blue_3": "#4C566A",

    "nord_white_0": "#D8DEE9",
    "nord_white_1": "#E5E9F0",
    "nord_white_2": "#ECEFF4",

    "nord_light_blue_0": "#5E81AC",
    "nord_light_blue_1": "#81A1C1",
    "nord_light_blue_2": "#88C0D0",
    "nord_light_blue_3": "#8FBCBB",

    "nord_red": "#BF616A",
    "nord_orange": "#D08770",
    "nord_yellow": "#EBCB8B",
    "nord_green": "#A3BE8C",
    "nord_purple": "#B48EAD"
}

# Remove the `#`, only needed that to trigger the highlighter in editors
for i in colors:
    colors[i] = colors[i][1:]


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])


keys = [
    
    Key(["control", "shift"], "Print", lazy.spawn('flameshot gui')),
    # Screenshots

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    Key([mod], "r", lazy.spawn("ulauncher-toggle"), desc="Run Ulauncher"),

    # Volume modifiers
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 -q set Master 1%+"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 -q set Master 1%-"), desc="Decrease volume"),
    Key([], "XF86AudioMute", lazy.spawn("amixer -D pulse set Master 1+ toggle"), desc="Mute speakers"),

    Key([mod], "XF86AudioRaiseVolume", lazy.spawn("bash /home/pythonaddike/.config/qtile/increase_mic_input.sh"), desc="Increase mic sensitivity"),
    Key([mod], "XF86AudioLowerVolume", lazy.spawn("bash /home/pythonaddike/.config/qtile/decrease_mic_input.sh"), desc="Decrease mic sensitivity"),

    # Display Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl -s set +2%"), desc="Increase display brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -s set 2%-"), desc="Decrease display brightness"),
]

groups = [
    Group(i) for i in 
    [
        "Browser",
        "Zoom",
        "Terminal",
        "Editor",
        "Misc-1",
        "Misc-2",
    ]
]

for i in range(len(groups)):
    keys.append(
        Key(
            [mod],
            str(i + 1),
            lazy.group[groups[i].name].toscreen(),
            desc="Switch to group {}".format(groups[i].name)
        )
    )

layouts = [
    layout.bsp.Bsp(
        border_width=3,
        margin=window_padding,
        border_focus=colors["nord_light_blue_3"],
        border_normal=colors["nord_yellow"]
    ),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font Mono",
    fontsize=15,
    padding=3,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # Manjaro Icon
                # TODO: Make it clickable, and display power options
                widget.Image(
                    filename="~/.config/qtile/icon.png",
                    margin=5,
                ),
                
                # Workspace list
                widget.GroupBox(
                    active=colors["nord_light_blue_1"],
                    inactive=colors["nord_white_0"],
                    highlight_method="block",
                    padding=5,
                    this_current_screen_border=colors["nord_dark_blue_2"],
                    other_current_screen_border=colors["nord_light_blue_1"],
                    this_screen_border=colors["nord_light_blue_1"],
                    other_screen_border=colors["nord_light_blue_1"],
                    font="JetBrainsMono Nerd Font Mono Bold"
                ),

                # Run commands
                # widget.Prompt(
                #     foreground=colors["nord_white_0"],
                #     cursor_color=colors["nord_white_2"]
                # ),
                
                # Spacer to center time widget
                widget.Spacer(),
                
                # Display time
                widget.Clock(format=' %d-%m-%Y %a %I:%M %p 🕓', foreground=colors["nord_green"]),
                
                # Spacer to center time widget
                widget.Spacer(),

                # Display background apps
                widget.Systray(),
                
                # Display connection info
                widget.Wlan(
                    interface="wlo1",
                    format=' {essid} {percent:2.0%} ',
                    disconnected_message="Disconnected ",
                    foreground=colors["nord_light_blue_3"]
                ),

                # Show speaker volume
                # Volume can be controlled by using F3, F2, and F1
                widget.Volume(fmt="🔊 {} ", foreground=colors["nord_purple"]),

                # Show display brightness
                # Brightness can be controlled by F4, and F5
                widget.Backlight(
                    backlight_name="intel_backlight",
                    format="🔅 {percent:2.0%}",
                    foreground=colors["nord_orange"]
                ),

                # Show battery levels
                widget.Battery(
                    charge_char="⚡",
                    full_char="🔋",
                    empty_char="⚠",
                    notify_below=0.2,
                    low_percentage=0.2,
                    format=' {char} {percent:2.0%} ',
                    update_interval=10,
                    foreground=colors["nord_yellow"]
                ),
            ],
            size=36,
            background=colors["nord_dark_blue_3"],
            margin=window_padding
        ),

        wallpaper="/home/pythonaddike/AllFolders/wallpapers/wild.png",
        wallpaper_mode="fill"
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ],

    border_width=0,
    max_border_width=0,
    fullscreen_border_width=0
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
