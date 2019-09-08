module Sudoku
  class Puzzle
    WIDTH = HEIGHT = 9
    CUBE_WIDTH = CUBE_HEIGHT = 3

    def initialize(puz)
      @puzzle = puz
      @possibilities = find_possibilities
    end

    def find_element_possibilities(row, col)
      return [@puzzle[row][col]] unless @puzzle[row][col].zero?

      find_row_poss(row, col) & find_col_poss(row, col) & find_cube_poss(row, col)
    end

    def find_other_col_poss(row, col)
      poss = []
      each_in_line(exclude: row) do |r|
        poss |= find_element_possibilities(r, col)
      end
      poss
    end

    def find_other_cube_poss(row, col)
      poss = []
      each_in_cube(row: row, col: col) do |r, c|
        next if r == row && c == col

        poss |= find_element_possibilities(r, c)
      end
      poss
    end

    def find_other_row_poss(row, col)
      poss = []
      each_in_line(exclude: col) do |c|
        poss |= find_element_possibilities(row, c)
      end
      poss
    end

    def get_element(row, col)
      @puzzle[row][col]
    end

    def get_possibilities(row, col)
      @possibilities[row][col]
    end

    def set_element(row, col, val)
      begin
        @puzzle[row][col] = val unless @puzzle[row][col].positive?
      rescue
      end
      update_possibilities(row, col)
    end

    def each(&_block)
      each_in_line do |r|
        each_in_line do |c|
          yield(r, c)
        end
      end
    end

    def to_s
      output = ''
      each_in_line do |r|
        output = append_line(output) if r % 3 == 0
        line = '|'
        each_in_line do |c|
          elem = get_element(r, c)
          line = "#{line} #{elem.positive? ? elem : '-'}#{((c + 1) % 3).zero? ? ' |' : ''}"
        end
        output = "#{output}#{line}\n"
      end
      append_line(output)
    end

    private

    def find_possibilities
      poss = []
      each_in_line do |r|
        poss[r] = []
        each_in_line do |c|
          poss[r][c] = find_element_possibilities(r, c)
        end
      end
      poss
    end

    def each_in_line(exclude: nil, &_block)
      (0..WIDTH - 1).each do |e|
        next if e == exclude

        yield(e)
      end
    end

    def find_row_poss(row, _col)
      poss = *(1..WIDTH)
      each_in_line do |c|
        val = @puzzle[row][c]
        poss -= [val] unless val.zero?
      end
      poss
    end

    def find_col_poss(row, col)
      poss = *(1..WIDTH)
      each_in_line(exclude: row) do |r|
        val = @puzzle[r][col]
        poss -= [val] unless val.zero?
      end
      poss
    end

    def find_cube_poss(row, col)
      poss = *(1..WIDTH)
      each_in_cube(row: row, col: col) do |r, c|
        val = @puzzle[r][c]
        poss -= [val] unless val.zero?
      end
      poss
    end

    def each_in_cube(row: nil, col: nil, &_block)
      row_offset = row / 3 * 3 unless row.nil?
      col_offset = col / 3 * 3 unless col.nil?
      (0..CUBE_WIDTH - 1).each do |r|
        (0..CUBE_HEIGHT - 1).each do |c|
          next if r == row && c == col

          yield(r + row_offset, c + col_offset)
        end
      end
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

    def append_line(text)
      "#{text}-------------------------\n"
    end
  end
end