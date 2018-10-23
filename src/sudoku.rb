#
#
#

class Sudoku

  def initialize(puz)
    @puzzle = puz
    @possibilities = find_possibilities
  end

  def get_element(x, y)
    @puzzle[x][y]
  end

  def set_element(x, y, val)
    begin
      if @puzzle[x][y] != '-'
        @puzzle[x][y] = val
      end
    rescue
    end
  end

  def find_possibilities
    row = 0
    poss = []
    @puzzle.each do |line|
      col = 0
      poss[row] = []
      line.each do |element|
        poss[row][col] = find_element_possibilities(row, col)
        col += 1
      end
      row += 1
    end
    poss
  end

  def find_element_possibilities(row, col)
    if @puzzle[row][col] == 0
      find_row_poss(row, col) & find_col_poss(row, col) & find_square_poss(row, col)
    else
      [@puzzle[row][col]]
    end
  end

  def find_row_poss(row, col)
    poss = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @puzzle[row].each do |val|
      poss = poss - [val] unless val == 0
    end
    poss
  end

  def find_col_poss(row, col)
    poss = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    [0, 1, 2, 3, 4, 5, 6, 7, 8].each do |r|
      val = @puzzle[r][col]
      poss = poss - [val] unless val == 0
    end
    poss
  end

  def find_square_poss(row, col)
    poss = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    row_offset = row/3 * 3
    col_offset = col/3 * 3
    [0, 1, 2].each do |r|
      [0, 1, 2].each do |c|
        val = @puzzle[r + row_offset][c + col_offset]
        poss = poss - [val] unless val == 0
      end
    end
    poss
  end

  def get_poss(row, col)
    @possibilities[row][col]
  end

end



def read_input_puzzle_from_file(input_file)
  puzzle = []
  input_file = 'puzzles/1.puzzle' if input_file == ''
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


puts 'Please provide the puzzle file:'
input_file = gets
puz = read_input_puzzle_from_file(input_file.chomp)

sud = Sudoku.new(puz)

# puts sud.get_element(4,8)
# sud.set_element(1,1,9)
# puts sud.get_element(1,1)

# sud.print_poss(0,0)

[0,1,2,3,4,5,6,7,8].each do |r|
  line = ""
  [0,1,2,3,4,5,6,7,8].each do |c|
    pos = sud.get_poss(r, c)
    if pos == nil or pos.length==0
      line = "#{line} -"
    else
      line = "#{line} (#{r}#{c})#{sud.get_poss(r, c)}"
    end
  end
  puts line
end