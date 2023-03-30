describe Slot do
  subject(:slot) { described_class.new(index) }

  let(:index) { 3 }

  describe '#temporary_assignment' do
    it 'changes value back after method is called' do
      current_value = slot.value
      slot.temporary_assignment('X')
      expect(slot.value).to eq current_value
    end

    it 'assigns the given value temporarily', :aggregate_failures do
      slot.temporary_assignment('X') do
        expect(slot.value).to eq('X')
      end

      expect(slot.value).not_to eq('X')
    end

    it 'yields the control when passing a block' do
      expect do |block|
        slot.temporary_assignment('O', &block)
      end.to yield_with_no_args
    end
  end

  describe '#taken?' do
    subject(:taken?) { slot.taken? }

    context 'when value is null' do
      it { is_expected.to be false }
    end

    context 'when value is set' do
      before { slot.value = 'X' }

      it { is_expected.to be true }
    end
  end

  describe '#to_s' do
    context 'when value is null' do
      it { expect(slot.to_s).to eq(index.to_s) }
    end

    context 'when value is set' do
      before do
        slot.value = 5
      end

      it 'gives set value back' do
        expect(slot.to_s).to eq("5")
      end
    end
  end
end
