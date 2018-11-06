module Sudoku
  class Puzzle

    def initialize(puz)
      @puzzle = puz
      @possibilities = find_possibilities
    end

    def find_possibilities
      poss = []
      self.each_row do |r|
        poss[r] = []
        self.each_column do |c|
          poss[r][c] = find_element_possibilities(r, c)
        end
      end
      poss
    end

    def each_row(exclude: nil, &block)
      (0..8).each do |c|
        next if c == exclude
        block.call(c)
      end
    end

    def each_column(&block)
      (0..8).each do |r|
        block.call(r)
      end
    end
    
    def each_cube(&block)
      (0..2).each do |r|
        (0..2).each do |c|
          block.call(r, c)
        end
      end
    end

    def find_element_possibilities(row, col)
      return [@puzzle[row][col]] if @puzzle[row][col] != 0
      find_row_poss(row, col) & find_col_poss(row, col) & find_cube_poss(row, col)
    end

    def find_row_poss(row, col)
      poss =* (1..9)
      each_column do |c|
        val = @puzzle[row][c]
        poss = poss - [val] unless val == 0
      end
      poss
    end

    def find_other_row_poss(row, col)
      poss = []
      each_column do |c|
        next if c == col
        poss = poss | find_element_possibilities(row, c)
      end
      poss
    end

    def find_col_poss(row, col)
      poss =* (1..9)
      each_row(exclude: row) do |r|
        val = @puzzle[r][col]
        poss = poss - [val] unless val == 0
      end
      poss
    end

    def find_other_col_poss(row, col)
      poss = []
      each_row do |r|
        next if r == row
        poss = poss | find_element_possibilities(r, col)
      end
      poss
    end

    def find_cube_poss(row, col)
      poss =* (1..9)
      row_offset = row/3 * 3
      col_offset = col/3 * 3
      each_cube do |r, c|
        val = @puzzle[r + row_offset][c + col_offset]
        poss = poss - [val] unless val == 0
      end
      poss
    end

    def find_other_cube_poss(row, col)
      poss = []
      row_offset = row/3 * 3
      col_offset = col/3 * 3
      each_cube do |r, c|
        next if r + row_offset == row and c + col_offset == col
        poss = poss | find_element_possibilities(r + row_offset, c + col_offset)
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
      each_column do |c|
        @possibilities[row][c] = find_element_possibilities(row, c)
      end
    end

    def update_possibilities_across_col(col)
      each_row do |r|
        @possibilities[r][col] = find_element_possibilities(r, col)
      end
    end

    def update_possibilities_across_cube(row, col)
      row_offset = row/3 * 3
      col_offset = col/3 * 3
      each_cube do |r, c|
        @possibilities[r][c] = find_element_possibilities(r, c)
      end
    end

    def get_possibilities(row, col)
      @possibilities[row][col]
    end

    def to_s
      output = ""
      each_row do |r|
        output = append_line(output) if r % 3 == 0
        line = "|"
        each_column do |c|
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