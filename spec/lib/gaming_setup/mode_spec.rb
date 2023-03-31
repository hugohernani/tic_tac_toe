describe GamingSetup::Mode do
  subject(:mode) { described_class.new(board) }

  let(:board) { Board.new(size: 2) }

  describe '#choose_message' do
    it 'shows a message to choose game mode' do
      expect(mode).to receive(:puts).with(/Which game mode/i)

      mode.choose_message
    end
  end

  describe '#ask' do
    context 'when is valid' do
      it 'asks to choose one option' do
        allow(mode).to receive(:gets).and_return('hh \n')

        choice = mode.ask

        expect(mode).to have_received(:gets)
      end
    end
  end
end
