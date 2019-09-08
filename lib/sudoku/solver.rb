module Sudoku
  require_relative 'puzzle'

  class Solver

    def initialize(input)
      @puzzle = Puzzle.new(input)
    end

    def solve
      no_updates = false
      until no_updates
        next if find_only_option
        next if find_only_poss_in_dimension(:cube)
        next if find_only_poss_in_dimension(:row)
        next if find_only_poss_in_dimension(:col)

        no_updates = true
      end
      puzzle
    end

    def find_only_option
      puzzle.each do |r, c|
        next if puzzle.get_element(r, c).positive?

        pos = puzzle.get_possibilities(r, c)
        if !pos.nil? && pos.length == 1
          puzzle.set_element(r, c, pos[0])
          return true
        end
      end
      false
    end

    def find_only_poss_in_dimension(dimension = :row)
      puzzle.each do |r, c|
        next if puzzle.get_element(r, c).positive?

        options = puzzle.get_possibilities(r, c) - find_other_poss(dimension, r, c)
        if options.length == 1
          puzzle.set_element(r, c, options.first)
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

    private

    attr_reader :puzzle
  end
end