# Ruby Sudoku

![Build Badge](https://github.com/truggeri/ruby-sudoku/workflows/Ruby/badge.svg)

The purpose of this project is to get a little practice with Ruby and the Ruby syntax. The idea is that this will serve as a sudoku solver.

## Running

To run the project locally, install the dependencies using [Bundler](https://bundler.io/), then run with.

```bash
bundle install
bundle exec ruby lib/sudoku/run_local.rb
```

## Algorithm

This section will describe the algorithm used to solve the puzzels. The basic idea is this.

1. Find the possible options for each empty space
2. Examine space-by-space for places with:
    1. Only one possibility
    2. Only space in the row with a possibility
    3. Only space in the column with a possibility
    4. Only space in the block with a possibility

## Input

This section will describe how to interface with the project. Ideally, I will include a web/HTTP api (using something like [Sinatra](http://sinatrarb.com/)), but that may be after the core of the application.

### Load from a file

When the application starts, it will request the path to a file that contains a puzzle. The puzzle file should be nine lines long. Each line contains a space seperated list of entries. Each entry is either a number if given in the puzzle or a dash to indicate the space is blank.

```bash
- 3 8 2 - - - 4 5
- 1 - 6 - 5 - - -
5 - 7 - 8 - - - -
3 - 1 - 6 2 - 7 -
9 - - 5 - 7 - - 4
- 4 - 8 3 - 6 - 2
- - - - 2 - 3 - 8
- - - 9 - 3 - 2 -
2 7 - - - 8 4 9 -
```

## Tests

There is a test suite written with [rspec](https://rspec.info/). Run it with,

```bash
bundle exec rspec ./spec/
```
