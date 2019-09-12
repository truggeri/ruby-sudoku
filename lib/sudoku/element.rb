module Sudoku
  class Element

    attr_reader :possibilities, :value, :row, :col

    def initialize(r, c, value = nil)
      @value         = value
      @possibilities = value.nil? ? Array.new(9) { |i| i + 1 } : []
      @row = r
      @col = c
    end

    def recalculate!(in_row, in_col, in_cube)
      return nil if solved?

      @possibilities -= (in_row + in_col + in_cube)
    end

    def solve(solution)
      @value = solution unless solved?
      @possibilities = []
    end

    def solved?
      !value.nil?
    end

    private

  end
end