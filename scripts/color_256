#!/bin/bash

# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.

for fgbg in 38 48 ; do #Foreground/Background
  for color in {0..16} {232..256}; do #Colors
    for attr in 0 1 2 3 4 7; do # Attr: normal bold dim italic underline inverted
      #Display the color
      color_code="${attr};${fgbg};5;${color}"
      echo -en "\e[${color_code}m ${color_code}\t\e[0m"
      #Display 10 colors per lines
    done
    echo #New line
  done
  echo #New line
done
exit 0
