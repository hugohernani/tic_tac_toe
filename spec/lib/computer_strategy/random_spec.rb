describe ComputerStrategy::Random do
  subject(:strategy) { described_class.new(board) }

  describe '#get_choice' do
    let(:board) { Board.new(size: 2) }

    it 'returns a not taken value from board slots' do
      board[1] = 'X'
      board[3] = 'X'

      available_slots = [2, 4]
      expect(available_slots).to include(strategy.get_choice)
    end
  end
end
