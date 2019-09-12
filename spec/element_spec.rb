require_relative '../lib/sudoku/element'

RSpec.describe Sudoku::Element do
  let(:klass) { Sudoku::Element.new(row, col, value) }
  let(:row)   { Random.rand(0..9) }
  let(:col)   { Random.rand(0..9) }
  let(:value) { nil }

  describe "#solve and #solved?" do
    subject { klass.solve(solution) }

    let(:solution) { Random.rand(1..9) }

    context "when not solved" do
      let(:value) { nil }

      it "is solved" do
        expect(klass.solved?).to       eq(false)
        expect(klass.value).to         eq(nil)
        subject
        expect(klass.solved?).to       eq(true)
        expect(klass.value).to         eq(solution)
        expect(klass.possibilities).to eq([])
      end
    end

    context "when already solved" do
      let(:value) { Random.rand(1..9) }

      it "is does not change" do
        expect(klass.solved?).to       eq(true)
        expect(klass.value).to         eq(value)
        subject
        expect(klass.solved?).to       eq(true)
        expect(klass.value).to         eq(value)
        expect(klass.possibilities).to eq([])
      end
    end
  end

  describe "#remove_possibilities" do
    let(:poss) { [1, 3, 9] }

    subject { klass.remove_possibilities(poss) }

    context "when not solved" do
      let(:value) { nil }

      it { expect(subject).to eq([2, 4, 5, 6, 7, 8]) }
    end

    context "when already solved" do
      let(:value) { Random.rand(1..9) }

      it { expect(subject).to eq(nil) }
    end
  end
end