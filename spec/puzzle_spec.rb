require_relative '../lib/sudoku/puzzle'

RSpec.describe Sudoku::Puzzle do
  let(:klass) { Sudoku::Puzzle.new(input) }
  let(:input) { read_puzzle_from_fixture('puzzles/1.puzzle') }

  describe "#get_element" do
    subject { klass.get_element(row, col) }

    context "when element is blank" do
      let(:row) { 0 }
      let(:col) { 0 }

      it { expect(subject).to eq(nil) }
    end

    context "when element is filled" do
      let(:row) { 0 }
      let(:col) { 1 }

      it { expect(subject).to eq(3) }
    end
  end

  shared_examples "an element with possibilities" do
    it "has expected value" do
      expect(subject).to include(*expected_possibilities)
      expect(subject).to eq([]) if expected_possibilities.size.zero?
    end
  end

  describe "#find_element_possibilities" do
    subject { klass.find_element_possibilities(row, col) }

    it_behaves_like "an element with possibilities" do
      let(:row) { 1 }
      let(:col) { 2 }
      let(:expected_possibilities) { [2, 4, 9] }
    end

    it_behaves_like "an element with possibilities" do
      let(:row) { 6 }
      let(:col) { 7 }
      let(:expected_possibilities) { [1, 5, 6] }
    end

    it_behaves_like "an element with possibilities" do
      let(:row) { 4 }
      let(:col) { 3 }
      let(:expected_possibilities) { [] }
    end
  end
end