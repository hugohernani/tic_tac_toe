describe HumanPlayer do
  subject(:player) { described_class.new(name: 'Player 1', sign: 'X') }

  describe '#get_move' do
    let(:mock_input) { "1\n" }

    before { allow(player).to receive(:gets).and_return(mock_input) }

    it 'asks for an input from user' do
      player.get_move

      expect(player).to have_received(:gets)
    end
  end
end
