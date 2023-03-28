describe GameControl do
  subject(:game_control) { described_class.new(board: board, players: players) }

  let(:board) do
    instance_double('Board', display: nil, finished?: nil,
                             ask_player: nil, apply_next_move: nil)
  end
  let(:players) do
    instance_double('GamePlayer', switch_active!: nil, current: nil,
                                  get_player: nil)
  end

  describe '#finished?' do
    it 'delegates the action to Board object' do
      game_control.finished?

      expect(board).to have_received(:finished?)
    end
  end

  describe '#display_board' do
    it 'delegates the action to Board object' do
      game_control.display_board

      expect(board).to have_received(:display)
    end
  end

  describe '#next_move!' do
    it 'handles move for current player' do
      game_control.next_move!

      expect(board).to have_received(:ask_player).once.ordered
      expect(board).to have_received(:apply_next_move).once.ordered
      expect(players).to have_received(:switch_active!)
    end
  end

  describe '#display_result' do
    context 'when board is fulfilled without an winner' do
      before { allow(board).to receive(:tie_result?).and_return(true) }

      it 'display a tie message' do
        message = "Game over.\nIt's a tie.\n"

        expect(game_control).to receive(:puts).with(message)

        game_control.display_result
      end
    end

    context 'when there is one winner' do
      let(:line) { Line.new(Slot.new(1, value: 'X')) }
      let(:winner) { HumanPlayer.new(sign: 'X') }
      let(:players) { GamePlayer.new(winner, double()) }
      
      before do
        allow(board).to receive(:tie_result?).and_return(false)
        allow(board).to receive(:crossed_line).and_return(line)
      end

      it 'display players name representation' do
        message = "Game over.\nWinner: Human(X).\n"

        expect(game_control).to receive(:puts).with(message)

        game_control.display_result
      end
    end
  end
end
