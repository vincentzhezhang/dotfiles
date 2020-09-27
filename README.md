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
- checkout https://github.com/zdcthomas/dmux (Rust alternative to tmuxinator)

### Bugs

- google-chrome XDG support for both system and cmd line is hacked

### Missing apps

- mainline: convenient kernel installer
- rofi: launcher for Gnome (best still goes to KRunner in KDE), needs a few add-ons to catch-up:
  - https://github.com/tcode2k16/rofi-chrome
- universal-ctags
- numix-icon-theme-circle
- flameshot: best screenshot and annotation software on Linux
- mpv (video player, better alternative to VLC)
- ffmpeg (for archiving videos and blurred lock screen)
- peek (screen recorder) sudo add-apt-repository ppa:peek-developers/stable


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

#### KDE

Note KDE is still superior imo because:

- still better performance
- better default apps
- consistent behaviour and appearance
- waaaaaaaaaaaay more customizable options by default

- ???

### Needs dynamic version / upgrades

- virtual_box

### Change installation method

- fzf, better to be managed by brew

### Post installation tweaks

- chrome-gnome-shell
- sync app settings
- gsettings: unbind system defaults:
  - e.g. ESC
- rofi config

# vim: set autoindent expandtab nowrap number textwidth=119 tabstop=2 shiftwidth=2 :
