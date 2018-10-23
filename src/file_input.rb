def read_input_puzzle_from_file(input_file)
  puzzle = []
  input_file = 'puzzles/3.puzzle' if input_file == ''
  File.open(input_file, "r") do |f|
    line_count = 0
    f.each_line do |line|
      col = 0
      puzzle[line_count] = []
      line.split(' ').each do |element|
        puzzle[line_count][col] = element.to_i
        col += 1
      end
      line_count += 1
    end
  end
  puzzle
end