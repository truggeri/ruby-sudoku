require_relative 'element'

module Sudoku
  # rubocop:disable Metrics/ClassLength
  class Puzzle
    WIDTH      = HEIGHT      = 9
    CUBE_WIDTH = CUBE_HEIGHT = 3

    def initialize(input)
      row = -1
      @new_puzzle = Array.new(WIDTH) do
        row += 1
        col = -1
        Array.new(HEIGHT) do
          col += 1
          value = input.shift
          Element.new(row, col, value&.positive? ? value : nil)
        end
      end

      (0..WIDTH - 1).each do |r|
        (0..HEIGHT - 1).each do |c|
          new_puzzle[r][c].remove_possibilities(row_values(r) + column_values(c) + cube_values(r, c))
        end
      end
    end

    def find_other_col_poss(row, col)
      poss = []
      each_in_line(exclude: row) do |r|
        poss |= new_puzzle[r][col].possibilities
      end
      poss
    end

    def find_other_cube_poss(row, col)
      poss = []
      each_in_cube(row: row, col: col) do |r, c|
        next if r == row && c == col

        poss |= new_puzzle[r][c].possibilities
      end
      poss
    end

    def find_other_row_poss(row, col)
      poss = []
      each_in_line(exclude: col) do |c|
        poss |= new_puzzle[row][c].possibilities
      end
      poss
    end

    def get_element(row, col)
      new_puzzle[row][col].value
    end

    def set_element(row, col, val)
      new_puzzle[row][col].solve(val)
      update_possibilities(row, col)
    end

    def each(&_block)
      each_in_line do |r|
        each_in_line do |c|
          yield(new_puzzle[r][c])
        end
      end
    end

    def to_s
      output = ''
      each_in_line do |r|
        output = append_line(output) if (r % 3).zero?
        line = '|'
        each_in_line do |c|
          elem = get_element(r, c)
          line = "#{line} #{elem&.positive? ? elem : '-'}#{((c + 1) % 3).zero? ? ' |' : ''}"
        end
        output = "#{output}#{line}\n"
      end
      append_line(output)
    end

    private

    attr_reader :puzzle, :new_puzzle

    def find_possibilities
      poss = []
      each_in_line do |r|
        poss[r] = []
        each_in_line do |c|
          poss[r][c] = new_puzzle[r][c].possibilities
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
      poss = *(1..HEIGHT)
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

    # rubocop:disable Metrics/AbcSize
    def update_possibilities(row, col)
      each_in_line do |i|
        unless i == col
          new_puzzle[row][i].remove_possibilities(row_values(row) + column_values(i) + cube_values(row, i))
        end
        unless i == row
          new_puzzle[i][col].remove_possibilities(row_values(i) + column_values(col) + cube_values(i, col))
        end
      end
      each_in_cube(row: row, col: col) do |r, c|
        unless r == row && c == col
          new_puzzle[r][c].remove_possibilities(row_values(r) + column_values(c) + cube_values(r, c))
        end
      end
    end
    # rubocop:enable Metrics/AbcSize

    def row_values(row)
      new_puzzle[row].map(&:value).compact
    end

    def column_values(col)
      values = []
      each_in_line do |r|
        values << new_puzzle[r][col]&.value
      end
      values.compact
    end

    def cube_values(row, col)
      values = []
      each_in_cube(row: row, col: col) do |r, c|
        values << new_puzzle[r][c]&.value
      end
      values.compact
    end

    def append_line(text)
      "#{text}-------------------------\n"
    end
  end
  # rubocop:enable Metrics/ClassLength
end
