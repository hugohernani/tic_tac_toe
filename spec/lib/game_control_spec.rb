describe GameControl do
  subject(:game_control) { described_class.new(board: board, players: players) }

  let(:board) do
    instance_double('Board', display: nil, finished?: nil,
                             ask_player: nil, apply_next_move: nil)
  end
  let(:players) { instance_double('GamePlayer', switch_active!: nil, current: nil) }

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
end
