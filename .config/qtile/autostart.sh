#!/usr/bin/env bash

nm-applet &
dunst &
picom --experimental-backend &
ulauncher --no-extensions --hide-window &
light-locker --lock-on-lid --no-late-locking &
