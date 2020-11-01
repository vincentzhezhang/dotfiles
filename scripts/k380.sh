#! /usr/bin/env bash
#
# Tweaks for the Logitech K380 Bluetooth keyboard
#

# disable the annoying XF86Sleep sent by Fn + L
xmodmap -e 'keycode 150='
