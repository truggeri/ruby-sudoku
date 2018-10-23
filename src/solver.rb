require './src/file_input.rb'
require './src/sudoku.rb'

def print_puzzle_poss(puzzle)
  (0..8).each do |r|
    line = ""
    (0..8).each do |c|
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

def find_only_one_poss(puzzle)
  overall_flag = false
  no_more_easy_flag = false
  until no_more_easy_flag
    no_more_easy_flag = true
    (0..8).each do |r|
      (0..8).each do |c|
        next if puzzle.get_element(r, c) > 0
        pos = puzzle.get_poss(r, c)
        if pos != nil and pos.length == 1
          puzzle.set_element(r, c, pos[0])
          no_more_easy_flag = false
          overall_flag = true
        end
      end
    end
  end
  overall_flag
end

def find_only_poss_in_row(puzzle)
  (0..8).each do |r|
    (0..8).each do |c|
      next if puzzle.get_element(r, c) > 0
      pos = puzzle.get_poss(r, c)
      options = pos - puzzle.find_other_row_poss(r, c)
      if options.length == 1
        puzzle.set_element(r, c, options[0])
        puts "(#{r}, #{c} - row, #{options[0]})"
        return true
      end
    end
  end
  false
end

def find_only_poss_in_col(puzzle)
  (0..8).each do |r|
    (0..8).each do |c|
      next if puzzle.get_element(r, c) > 0
      pos = puzzle.get_poss(r, c)
      options = pos - puzzle.find_other_col_poss(r, c)
      if options.length == 1
        puzzle.set_element(r, c, options[0])
        puts "(#{r}, #{c} - col, #{options[0]})"
        return true
      end
    end
  end
  false
end

puts 'Please provide the puzzle file:'
input_file = gets
input = read_input_puzzle_from_file(input_file.chomp)

puzzle = Sudoku.new(input)

loops = 0
stuck = false
until stuck
  puzzle.print
  loops += 1
  puts "=> iteration #{loops}"
  find_only_one_poss(puzzle)
  next if find_only_poss_in_row(puzzle)
  next if find_only_poss_in_col(puzzle)
  stuck = true
end

puts "--- #{loops} iterations"
puzzle.print