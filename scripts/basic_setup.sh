#! /usr/bin/env bash

#
# Essential system/app tweaks
#

# TODO
#
# swap settings
#
# temporary
# cat /proc/sys/vm/swappiness
# To temporarily set swap to 0 (as suggested by SpamapS):

# This will empty your swap and transfer all the swap back into memory. First make sure you have enough memory available by viewing the resources tab of gnome-system-monitor, your free memory should be greater than your used swap. This process may take a while, use gnome-system-monitor to monitor and verify the progress.
#
# sudo swapoff --all
# To set the new value to 0:
#
# sudo sysctl vm.swappiness=0
# To turn swap back on:
#
# sudo swapon --all
# To permanently set swappiness to 0:
#
# sudoedit /etc/sysctl.conf
# Add this line vm.swappiness = 0
# sudo shutdown -r now # restart system
