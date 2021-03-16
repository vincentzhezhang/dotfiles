# Dotfiles

Place for my lovely dot files

## Structure

```
.
├── config/
├── docs/
├── README.md
└── scripts/
```

- `config`: same structure as `$XDG_CONFIG_HOME`
- `docs`: other useful craps about this repo
- `scripts`: misc scripts come handy at times

## Install

Dry-run by default:

```sh
./script/install
```

Check the output see if it make sense, then:

```sh
SHIT_GOT_REAL=x ./script/install
```

## Scripts

All the scripts that can make modifications are executed in dry-run mode by
default, add SHIT_GOT_REAL=x before the script to make it do the real work.

## Tips

- bash built-ins are normally faster than command line alternatives, e.g. bash regex match is ~50% quicker than grep

## TOOD

### Features

- apply XDG settings to non-terminal started apps
- system performance tuning according https://wiki.archlinux.org/index.php/Improving_performance
- vim global words list

### Bugs

- google-chrome XDG support for both system and cmd line is hacked

### Missing apps

- rofi: launcher for Gnome (best still goes to KRunner in KDE), needs a few add-ons to catch-up:
  - https://github.com/tcode2k16/rofi-chrome


### Missing gadgets

- better weather forecasting text widget, that has:
  - temperature
  - location
  - summary
  - short minutes forecast if weather is not good

### RICE

- Color scheme: currently using Nord

### Environment specific add-ons

I am distro hopper so need a bunch of apps

#### Gnome

- luncher: rofi
- window manager (kinda): GTile https://github.com/gTile/gTile
- gsettings script:
  - which can automatically set the shortcut keys (really annoying to do it manually), and default system settings don't have it
- dark mode simulation
  - https://gitlab.com/rmnvgr/nightthemeswitcher-gnome-shell-extension/
  - for chrome, in chrome://settings/appearance, change Theme to use GTK+

#### KDE

Note KDE is still superior imo because:

- still better performance
- better default apps
- consistent behaviour and appearance
- waaaaaaaaaaaay more customizable options by default

### Post installation tweaks

- chrome-gnome-shell
- sync app settings
- rofi config

<!-- vim: set autoindent expandtab nowrap number textwidth=119 tabstop=2 shiftwidth=2 : -->
