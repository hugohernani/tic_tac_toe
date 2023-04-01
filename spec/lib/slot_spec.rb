describe Slot do
  subject(:slot) { described_class.new(index) }

  let(:index) { 3 }
  let(:x_sign) { PlayerSign.new(value: 'X') }
  let(:o_sign) { PlayerSign.new(value: 'O') }

  describe '#temporary_assignment' do
    it 'changes value back after method is called' do
      current_value = slot.value
      slot.temporary_assignment(x_sign)
      expect(slot.value).to eq current_value
    end

    it 'assigns the given value temporarily', :aggregate_failures do
      slot.temporary_assignment(x_sign) do
        expect(slot.value).to eq(x_sign)
      end

      expect(slot.value).not_to eq(x_sign)
    end

    it 'yields the control when passing a block' do
      expect do |block|
        slot.temporary_assignment(o_sign, &block)
      end.to yield_with_no_args
    end
  end

  describe '#taken?' do
    subject(:taken?) { slot.taken? }

    context 'when value is null' do
      it { is_expected.to be false }
    end

    context 'when value is set' do
      before { slot.value = x_sign }

      it { is_expected.to be true }
    end
  end

  describe '#to_s' do
    context 'when value is null' do
      it { expect(slot.to_s).to eq(index.to_s) }
    end

    context 'when value is set' do
      before do
        slot.value = x_sign
      end

      it 'gives set value back' do
        expect(slot.to_s).to eq(x_sign.to_s)
      end
    end
  end
end
