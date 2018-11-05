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
      find_row_poss(row, col) & find_col_poss(row, col) & find_cube_poss(row, col)
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

  def find_other_row_poss(row, col)
    poss = []
    (0..8).each do |c|
      next if c == col
      poss = poss | find_element_possibilities(row, c)
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

  def find_other_col_poss(row, col)
    poss = []
    (0..8).each do |r|
      next if r == row
      poss = poss | find_element_possibilities(r, col)
    end
    poss
  end

  def find_cube_poss(row, col)
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

  def find_other_cube_poss(row, col)
    poss = []
    row_offset = row/3 * 3
    col_offset = col/3 * 3
    (0..2).each do |r|
      (0..2).each do |c|
        next if r + row_offset == row and c + col_offset == col
        poss = poss | find_element_possibilities(r + row_offset, c + col_offset)
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
    update_possibilities_across_row(row)
    update_possibilities_across_col(col)
    update_possibilities_across_cube(row, col)
  end

  def update_possibilities_across_row(row)
    (0..8).each do |c|
      @possibilities[row][c] = find_element_possibilities(row, c)
    end
  end

  def update_possibilities_across_col(col)
    (0..8).each do |r|
      @possibilities[r][col] = find_element_possibilities(r, col)
    end
  end

  def update_possibilities_across_cube(row, col)
    row_offset = row/3 * 3
    col_offset = col/3 * 3
    (0..2).each do |r|
      (0..2).each do |c|
        @possibilities[r][c] = find_element_possibilities(r, c)
      end
    end
  end

  def get_possibilities(row, col)
    @possibilities[row][col]
  end

  def to_s
    output = ""
    (0..8).each do |r|
      output = append_line(output) if r % 3 == 0
      line = "|"
      (0..8).each do |c|
        elem = get_element(r, c)
        line = "#{line} #{elem > 0 ? elem : '-'}#{(c+1) % 3 == 0 ? ' |': ''}"
      end
      output = "#{output}#{line}\n"
    end
    output = append_line(output)
  end

  def append_line(text)
    "#{text}-------------------------\n"
  end
end