describe BoardCell do
  subject(:board_cell) { described_class.new(board) }

  let(:board) { Board.new(size: 3) }

  describe '#cell_for' do
    subject(:cell_for) { board_cell.cell_for(spot) }
    let(:spot) { 2 }
    
    context 'when given spot is taken' do
      before { board[spot] = 'X' }

      it 'gives a null value' do
        is_expected.to be nil
      end
    end

    context 'when given spot is not taken' do
      it 'gives found Slot object back' do
        is_expected.to be_a(Slot)
      end
    end
  end
end
