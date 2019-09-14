require_relative 'puzzle'

module Sudoku
  class Solver

    def initialize(input)
      @puzzle = Puzzle.new(input)
    end

    def solve
      steps = 0
      no_updates = false
      until no_updates
        steps += 1
        next if find_only_poss_in_dimension(:unique)
        next if find_only_poss_in_dimension(:cube)
        next if find_only_poss_in_dimension(:row)
        next if find_only_poss_in_dimension(:col)

        no_updates = true
      end
      puzzle
    end

    private

    attr_reader :puzzle

    def find_only_poss_in_dimension(dimension = :row)
      puzzle.each do |element|
        next if element.solved?

        options = element.possibilities - find_other_poss(dimension, element.row, element.col)
        if options.size == 1
          puzzle.set_element(element.row, element.col, options.first)
          return true
        end
      end
      false
    end

    def find_other_poss(dimension, row, col)
      case dimension
      when :row  then puzzle.find_other_row_poss(row, col)
      when :col  then puzzle.find_other_col_poss(row, col)
      when :cube then puzzle.find_other_cube_poss(row, col)
      else []
      end
    end
  end
end