describe Line do
  subject(:line) { described_class.new(slot1, slot2, slot3) }

  describe '#uniq?' do
    subject(:uniq?) { line.uniq? }

    context 'when all slots hold the same value' do
      let(:slot1) { Slot.new(0, value: 'X') }
      let(:slot2) { Slot.new(1, value: 'X') }
      let(:slot3) { Slot.new(2, value: 'X') }

      it { is_expected.to be true }
    end

    context 'when at least one slot holds a different value' do
      let(:slot1) { Slot.new(0, value: 'X') }
      let(:slot2) { Slot.new(1, value: 'X') }
      let(:slot3) { Slot.new(2, value: '0') }

      it { is_expected.to be false }
    end
  end
end
