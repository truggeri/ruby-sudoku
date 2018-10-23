require_relative 'file_input'
require_relative 'solver'

puts 'Please provide the puzzle file:'
input_file = gets

puzzle_solver = Solver.new(read_input_puzzle_from_file(input_file.chomp))
puzzle_solver.solve()