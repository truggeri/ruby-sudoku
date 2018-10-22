# Ruby Sudoku

The purpose of this project is to get a little practice with Ruby and the Ruby syntax. The idea is that this will serve as a sudoku solver that given a puzzel will return the solved puzzel.

## The algorithm

This section will describe the algorithm used to solve the puzzels. The basic idea is this.

1. Find the possible options for each empty space
2. Examine space-by-space for places with:
    1. Only one possibility
    2. Only space in the row with a possibility
    3. Only space in the column with a possibility
    4. Only space in the block with a possibility

## Interface

This section will descibe how to interface with the project. Ideally, I will include a web/HTTP api (using something like Sinatra), but that may be after the core of the application.
