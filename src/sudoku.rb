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
