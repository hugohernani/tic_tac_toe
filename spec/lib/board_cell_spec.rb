describe BoardCell do
  subject(:board_cell) { described_class.new(board) }

  let(:board) { Board.new(size: size, starts_with: 1) }

  describe '#cell_for' do
    context 'when given spot is taken' do
      let(:spot) { 2 }

      before { board[spot] = 'X' }

      it 'gives a null value' do
        expect(board.cell_for(spot)).to eq nil
      end
    end
  end
end
