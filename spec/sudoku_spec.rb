require_relative '../lib/sudoku/solver'

RSpec.describe Sudoku do
  it 'has a version number' do
    expect(Sudoku::VERSION).not_to be nil
  end

  context 'when using a Sudoku::Solver' do
    let(:puzzle) { read_puzzle_from_fixture(filename) }
    let(:solver) { Sudoku::Solver.new(puzzle) }

    subject { solver.solve }

    context "when input is '1.puzzle'" do
      let(:filename) { 'puzzles/1.puzzle' }

      it 'gives correct solution' do
        expect(subject.to_s).to eq("-------------------------
| 6 3 8 | 2 9 1 | 7 4 5 |
| 4 1 9 | 6 7 5 | 2 8 3 |
| 5 2 7 | 3 8 4 | 9 6 1 |
-------------------------
| 3 8 1 | 4 6 2 | 5 7 9 |
| 9 6 2 | 5 1 7 | 8 3 4 |
| 7 4 5 | 8 3 9 | 6 1 2 |
-------------------------
| 1 9 4 | 7 2 6 | 3 5 8 |
| 8 5 6 | 9 4 3 | 1 2 7 |
| 2 7 3 | 1 5 8 | 4 9 6 |
-------------------------
")
      end
    end

    context "when input is '2.puzzle'" do
      let(:filename) { 'puzzles/1.puzzle' }

      it 'gives correct solution' do
        expect(subject.to_s).to eq("-------------------------
| 6 3 8 | 2 9 1 | 7 4 5 |
| 4 1 9 | 6 7 5 | 2 8 3 |
| 5 2 7 | 3 8 4 | 9 6 1 |
-------------------------
| 3 8 1 | 4 6 2 | 5 7 9 |
| 9 6 2 | 5 1 7 | 8 3 4 |
| 7 4 5 | 8 3 9 | 6 1 2 |
-------------------------
| 1 9 4 | 7 2 6 | 3 5 8 |
| 8 5 6 | 9 4 3 | 1 2 7 |
| 2 7 3 | 1 5 8 | 4 9 6 |
-------------------------
")
      end
    end

    context "when input is '3.puzzle'" do
      let(:filename) { 'puzzles/3.puzzle' }

      it 'gives correct solution' do
        expect(subject.to_s).to eq("-------------------------
| 6 5 3 | 7 9 2 | 8 1 4 |
| 1 9 8 | 5 3 4 | 7 2 6 |
| 7 2 4 | 8 6 1 | 5 9 3 |
-------------------------
| 9 8 6 | 4 1 7 | 3 5 2 |
| 4 3 7 | 2 5 9 | 1 6 8 |
| 5 1 2 | 3 8 6 | 4 7 9 |
-------------------------
| 8 7 1 | 9 2 3 | 6 4 5 |
| 3 4 9 | 6 7 5 | 2 8 1 |
| 2 6 5 | 1 4 8 | 9 3 7 |
-------------------------
")
      end
    end
  end
end