describe GamePlayer do
  subject(:game_player) do
    described_class.new(first_player, second_player)
  end

  let(:first_player) { HumanPlayer.new(sign: 'X') }
  let(:second_player) { HumanPlayer.new(sign: 'O') }

  describe '#switch_active!' do
    it 'changes current player', :aggregate_failures do
      expect(game_player.current).to eq(first_player)

      game_player.switch_active!

      expect(game_player.current).to eq(second_player)
    end
  end

  describe '#get_player' do
    it 'chooses player by given sign' do
      expect(game_player.get_player('X')).to eq first_player
    end
  end
end
