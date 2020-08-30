module Sudoku
  class Element
    attr_reader :possibilities, :value, :row, :col

    def initialize(row, col, value = nil)
      @value         = value
      @possibilities = value.nil? ? Array.new(9) { |i| i + 1 } : []
      @row           = row
      @col           = col
    end

    def remove_possibilities(possibilities)
      return nil if solved? || possibilities.empty?

      @possibilities -= possibilities
    end

    def solve(solution)
      return nil if solved? || !possibilities.include?(solution)

      @value = solution
      @possibilities = []
      value
    end

    def solved?
      !value.nil?
    end
  end
end
