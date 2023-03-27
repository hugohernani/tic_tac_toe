describe Slot do
  subject(:slot) { described_class.new(index) }

  let(:index) { 3 }

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
