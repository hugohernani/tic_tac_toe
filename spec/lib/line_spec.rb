describe Line do
  subject(:line) { described_class.new(slot1, slot2, slot3) }

  describe '#uniq_slot' do
    context 'when all slots hold the same value' do
      let(:slot1) { Slot.new(0, value: 'X') }
      let(:slot2) { Slot.new(1, value: 'X') }
      let(:slot3) { Slot.new(2, value: 'X') }

      it 'gives uniq slot object back', :aggregate_failures do
        slot = line.uniq_slot

        expect(slot).to be_a(Slot)
        expect(slot.value).to eq('X')
      end
    end
  end

  describe '#crossed?' do
    subject(:crossed?) { line.crossed? }

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

    context 'when all slots holds the same value, but nil' do
      let(:slot1) { Slot.new(0, value: nil) }
      let(:slot2) { Slot.new(1, value: nil) }
      let(:slot3) { Slot.new(2, value: nil) }

      it { is_expected.to be false }
    end
  end
end
