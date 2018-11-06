module Sudoku
  require_relative 'puzzle'

  class Solver

    def initialize(input)
      @input = input
      @puzzle = Puzzle.new(@input)
      puts @puzzle
    end

    def solve
      loops = 0
      stuck = false
      until stuck
        loops += 1
        find_only_one_poss(@puzzle)
        next if find_only_poss_in_dimension(@puzzle, :cube)
        next if find_only_poss_in_dimension(@puzzle, :row)
        next if find_only_poss_in_dimension(@puzzle, :col)
        
        stuck = true
      end
      @puzzle
    end

    def find_only_one_poss(puzzle)
      overall_flag = false
      no_more_easy_flag = false
      until no_more_easy_flag
        no_more_easy_flag = true
        puzzle.each do |r, c|
          next if puzzle.get_element(r, c) > 0
          pos = puzzle.get_possibilities(r, c)
          if pos != nil and pos.length == 1
            puzzle.set_element(r, c, pos[0])
            no_more_easy_flag = false
            overall_flag = true
          end
        end
      end
      overall_flag
    end

    def find_only_poss_in_dimension(puzzle, dimension=:row)
      puzzle.each do |r, c|
        next if puzzle.get_element(r, c) > 0
        pos = puzzle.get_possibilities(r, c)
        others = case dimension
          when :col then puzzle.find_other_col_poss(r, c)
          when :cube then puzzle.find_other_cube_poss(r, c)
          else puzzle.find_other_row_poss(r, c)
          end
        options = pos - others
        if options.length == 1
          puzzle.set_element(r, c, options[0])
          puts "(#{r}, #{c} - #{dimension}, #{options[0]})"
          return true
        end
      end
      false
    end
  end
end