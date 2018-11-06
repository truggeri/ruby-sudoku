module Sudoku
  require_relative 'solver'

  def self.read_input_puzzle_from_file(input_file)
    puzzle = []
    input_file = 'puzzles/3.puzzle' if input_file == ''
    File.open(input_file, "r") do |f|
      row = 0
      f.each_line do |line|
        col = 0
        puzzle[row] = []
        line.split(' ').each do |element|
          puzzle[row][col] = element.to_i
          col += 1
        end
        row += 1
      end
    end
    puzzle
  end

  puts 'Please provide the puzzle file:'
  input_file = gets.chomp

  puzzle_solver = Solver.new(self.read_input_puzzle_from_file(input_file))
  puts puzzle_solver.solve
end