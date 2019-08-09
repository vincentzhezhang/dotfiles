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
