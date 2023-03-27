describe BoardPlayerChoice do
  subject(:board_player_choice) { described_class.new(board) }

  let(:board) { Board.new(size: 3) }

  describe '#get_move_for' do
    context 'when player is HumanPlayer' do
      let(:player) { HumanPlayer.new(sign: 'O') }

      it 'delegates call to get_move on player' do
        allow(player).to receive(:get_move)

        board_player_choice.get_move_for(player)

        expect(player).to have_received(:get_move)
      end
    end

    xcontext 'when player is ComputerPlayer' do
      let(:player) { ComputerPlayer.new(sign: 'X') }

      # TODO
    end
  end
end
