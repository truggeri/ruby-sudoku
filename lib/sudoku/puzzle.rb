module Sudoku
  class Puzzle
    WIDTH = HEIGHT = 9
    CUBE_WIDTH = CUBE_HEIGHT = 3

    def initialize(puz)
      @puzzle = puz
      @possibilities = find_possibilities
    end

    def find_possibilities
      poss = []
      self.each_in_line do |r|
        poss[r] = []
        self.each_in_line do |c|
          poss[r][c] = find_element_possibilities(r, c)
        end
      end
      poss
    end

    def each_in_line(exclude: nil, &block)
      (0..WIDTH-1).each do |e|
        next if e == exclude
        block.call(e)
      end
    end

    def find_element_possibilities(row, col)
      return [@puzzle[row][col]] if @puzzle[row][col] != 0
      find_row_poss(row, col) & find_col_poss(row, col) & find_cube_poss(row, col)
    end

    def find_row_poss(row, col)
      poss =* (1..WIDTH)
      each_in_line do |c|
        val = @puzzle[row][c]
        poss = poss - [val] unless val == 0
      end
      poss
    end

    def find_other_row_poss(row, col)
      poss = []
      each_in_line(exclude: col) do |c|
        poss = poss | find_element_possibilities(row, c)
      end
      poss
    end

    def find_col_poss(row, col)
      poss =* (1..WIDTH)
      each_in_line(exclude: row) do |r|
        val = @puzzle[r][col]
        poss = poss - [val] unless val == 0
      end
      poss
    end

    def find_other_col_poss(row, col)
      poss = []
      each_in_line(exclude: row) do |r|
        poss = poss | find_element_possibilities(r, col)
      end
      poss
    end

    def find_cube_poss(row, col)
      poss =* (1..WIDTH)
      each_in_cube(row: row, col: col) do |r, c|
        val = @puzzle[r][c]
        poss = poss - [val] unless val == 0
      end
      poss
    end

    def each_in_cube(row: nil, col: nil, &block)
      row_offset = row/3 * 3 unless row.nil?
      col_offset = col/3 * 3 unless col.nil?
      (0..CUBE_WIDTH-1).each do |r|
        (0..CUBE_HEIGHT-1).each do |c|
          next if r == row and c == col
          block.call(r + row_offset, c + col_offset)
        end
      end
    end

    def find_other_cube_poss(row, col)
      poss = []
      each_in_cube(row: row, col: col) do |r, c|
        next if r == row and c == col
        poss = poss | find_element_possibilities(r, c)
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
      each_in_line do |i|
        @possibilities[row][i] = find_element_possibilities(row, i) unless i == col
        @possibilities[i][col] = find_element_possibilities(i, col) unless i == row
      end
      each_in_cube(row: row, col: col) do |r, c|
        @possibilities[r][c] = find_element_possibilities(r, c)
      end
    end

    def get_possibilities(row, col)
      @possibilities[row][col]
    end

    def to_s
      output = ""
      each_in_line do |r|
        output = append_line(output) if r % 3 == 0
        line = "|"
        each_in_line do |c|
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
end