require './src/file_input.rb'
require './src/sudoku.rb'

def print_puzzle_poss(puzzle)
  [0,1,2,3,4,5,6,7,8].each do |r|
    line = ""
    [0,1,2,3,4,5,6,7,8].each do |c|
      pos = puzzle.get_poss(r, c)
      if pos == nil or pos.length == 0
        line = "#{line} -"
      else
        line = "#{line} #{puzzle.get_poss(r, c)}"
      end
    end
    puts line
  end
end

puts 'Please provide the puzzle file:'
input_file = gets
input = read_input_puzzle_from_file(input_file.chomp)

puzzle = Sudoku.new(input)

puts '--- Possiblilites ---'
print_puzzle_poss(puzzle)

no_more_easy_flag = false
until no_more_easy_flag
  no_more_easy_flag = true
  [0,1,2,3,4,5,6,7,8].each do |r|
    [0,1,2,3,4,5,6,7,8].each do |c|
      if puzzle.get_element(r, c) > 0
        next
      end
      pos = puzzle.get_poss(r, c)
      if pos != nil and pos.length == 1
        puzzle.set_element(r, c, pos[0])
        no_more_easy_flag = false
      end
    end
  end
end

puzzle.print