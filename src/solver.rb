require './src/file_input.rb'
require './src/sudoku.rb'

def print_puzzle_poss(puzzle)
  [0,1,2,3,4,5,6,7,8].each do |r|
    line = ""
    [0,1,2,3,4,5,6,7,8].each do |c|
      pos = puzzle.get_poss(r, c)
      if pos == nil or pos.length==0
        line = "#{line} -"
      else
        line = "#{line} (#{r}#{c})#{puzzle.get_poss(r, c)}"
      end
    end
    puts line
  end
end

puts 'Please provide the puzzle file:'
input_file = gets
input = read_input_puzzle_from_file(input_file.chomp)

puzzle = Sudoku.new(input)

print_puzzle_poss(puzzle)