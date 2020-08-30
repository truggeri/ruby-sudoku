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

  describe "#set_element" do
    subject { klass.set_element(row, col, val) }

    context "when already set" do
      let(:row) { 8 }
      let(:col) { 7 }
      let(:val) { 1 }

      it "changes nothing" do
        subject
        expect(klass.get_element(row, col)).to eq(9)
      end
    end

    context "when element not set" do
      let(:row) { 0 }
      let(:col) { 0 }

      context "when value provided is valid" do
        let(:val) { 6 }

        it "becomes value" do
          subject
          expect(klass.get_element(row, col)).to eq(val)
        end
      end

      context "when value provided is not valid" do
        let(:val) { 8 }

        it "does not become value" do
          subject
          expect(klass.get_element(row, col)).to eq(nil)
        end
      end
    end
  end

  describe "#each" do
    it "iterates WIDTH^2 times" do
      counter = 0
      klass.each { counter += 1 }
      expect(counter).to eq(Sudoku::Puzzle::WIDTH.pow(2))
    end

    it "yields Sudoku::Element instances" do
      result_class = nil
      klass.each { |elem| result_class = elem.class }
      expect(result_class).to eq(Sudoku::Element)
    end
  end
end
