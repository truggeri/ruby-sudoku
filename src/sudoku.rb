#
#
#

class Sudoku

  def initialize(puz)
    @puzzle = puz
    @possibilities = find_possibilities()
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
    find_row_poss(row, col) | find_col_poss(row, col) | find_square_poss(row, col)
  end

  def find_row_poss(row, col)
    [1]
  end

  def find_col_poss(row, col)
    [1, 2]
  end

  def find_square_poss(row, col)
    [2, 3]
  end

  def print_poss(row, col)
    puts @possibilities[row][col]
  end

end



def read_input_puzzle_from_file(input_file)
  puzzle = []
  File.open(input_file.chomp, "r") do |f|
    line_count = 0
    f.each_line do |line|
      col = 0
      puzzle[line_count] = []
      line.split(' ').each do |element|
        puzzle[line_count][col] = element
        col += 1
      end
      line_count += 1
    end
  end
  puzzle
end


puts 'Please provide the puzzle file:'
input_file = gets
puz = read_input_puzzle_from_file(input_file)

sud = Sudoku.new(puz)

puts sud.get_element(4,8)
sud.set_element(1,1,9)
puts sud.get_element(1,1)

puts sud.print_poss(0,0)