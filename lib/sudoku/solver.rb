module Sudoku
  require_relative 'puzzle'

  class Solver

    def initialize(input)
      @input = input
      @puzzle = Puzzle.new(@input)
      # puts @puzzle
    end

    def solve
      loops = 0
      no_updates = false
      until no_updates
        loops += 1
        next if find_only_option()
        next if find_only_poss_in_dimension(:cube)
        next if find_only_poss_in_dimension(:row)
        next if find_only_poss_in_dimension(:col)
        no_updates = true
      end
      @puzzle
    end

    def find_only_option
      @puzzle.each do |r, c|
        next if @puzzle.get_element(r, c) > 0
        pos = @puzzle.get_possibilities(r, c)
        if pos != nil and pos.length == 1
          @puzzle.set_element(r, c, pos[0])
          return true
        end
      end
      false
    end

    def find_only_poss_in_dimension(dimension=:row)
      @puzzle.each do |r, c|
        next if @puzzle.get_element(r, c) > 0
        options = @puzzle.get_possibilities(r, c) - find_other_poss(dimension, r, c)
        if options.length == 1
          @puzzle.set_element(r, c, options[0])
          # puts "(#{r}, #{c} - #{dimension}, #{options[0]})"
          return true
        end
      end
      false
    end

    def find_other_poss(dimension, r, c)
      return case dimension
        when :row then @puzzle.find_other_row_poss(r, c)
        when :col then @puzzle.find_other_col_poss(r, c)
        when :cube then @puzzle.find_other_cube_poss(r, c)
        else []
        end
    end
  end
end