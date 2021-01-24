# Dumb Status Line

I am a bit tired of various status line solutions out there in the wild, and
the only thing I ever want is a dumb status line that shows some simple text,
period.

## Structure

The app include 3 major parts;

- sources: contains modules that produce primitive data
- renderers: contains modules that render source to different format targeting different platform
- main: orchestrating the logic

## Features

TODO: 

- multiple output mode
- optional threshold based coloring

### Stats

- [x] World Clock
- [x] Memory usage
- [x] Load Average
- [x] CPU percent
- [x] Network Speed
- [x] Weather
- [x] Exchange Rate
- [x] Latencies
- [x] Temperature

## Development setup

```bash
conda env create --name dsl --file environment.yaml
conda activate dsl
python setup.py develop
```

## Build

```bash
./build.sh
```

## Run

```bash
./run.sh
```
