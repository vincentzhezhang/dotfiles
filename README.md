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

### Bugs

- google-chrome XDG support for both system and cmd line is hacked

### Missing apps

- rofi
- universal-ctags
- numix-icon-theme-circle
- flameshot

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
