module Sudoku
  require_relative 'solver'

  def self.read_input_puzzle_from_file(input_file)
    puzzle = []
    File.open(input_file, 'r') do |f|
      f.each_line do |line|
        puzzle.push([])
        line.split(' ').each do |element|
          puzzle.last.push(element.to_i)
        end
      end
    end
    puzzle.flatten
  end

  puts 'Please provide the puzzle file:'
  input_file = gets.chomp
  input = input_file == '' ? 'puzzles/1.puzzle' : input_file

  puzzle_solver = Solver.new(read_input_puzzle_from_file(input))
  solution = puzzle_solver.solve

  puts solution
end
