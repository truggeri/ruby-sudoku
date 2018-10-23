#
#
#

class Sudoku

  def initialize(puz)
    @puzzle = puz
    @possibilities = find_possibilities
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
    poss =* (1..9)
    @puzzle[row].each do |val|
      poss = poss - [val] unless val == 0
    end
    poss
  end

  def find_col_poss(row, col)
    poss =* (1..9)
    (0..8).each do |r|
      val = @puzzle[r][col]
      poss = poss - [val] unless val == 0
    end
    poss
  end

  def find_square_poss(row, col)
    poss =* (1..9)
    row_offset = row/3 * 3
    col_offset = col/3 * 3
    (0..2).each do |r|
      (0..2).each do |c|
        val = @puzzle[r + row_offset][c + col_offset]
        poss = poss - [val] unless val == 0
      end
    end
    poss
  end

  def get_element(x, y)
    @puzzle[x][y]
  end

  def set_element(row, col, val)
    begin
      @puzzle[row][col] = val unless @puzzle[row][col] > 0
    rescue
    end
    update_possibilities(row, col)
  end

  def update_possibilities(row, col)
    (0..8).each do |r|
      @possibilities[r][col] = find_element_possibilities(r, col)
    end

    (0..8).each do |c|
      @possibilities[row][c] = find_element_possibilities(row, c)
    end

    row_offset = row/3 * 3
    col_offset = col/3 * 3
    (0..2).each do |r|
      (0..2).each do |c|
        @possibilities[r][c] = find_element_possibilities(r, c)
      end
    end
  end

  def get_poss(row, col)
    @possibilities[row][col]
  end

  def print()
    (0..8).each do |r|
      line = ""
      (0..8).each do |c|
        elem = get_element(r, c)
        line = "#{line} #{elem > 0 ? elem : '-'}"
      end
      puts line
    end
  end
end
