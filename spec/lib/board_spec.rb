describe Board do
  subject(:board) { described_class.new(size: size) }

  describe '#valid_move?' do
    subject(:valid_move?) { board.valid_move?(spot) }

    let(:size) { 3 }
    let(:spot) { 2 }

    context 'when spot is taken' do
      before { board[spot] = 'X' }

      it { is_expected.to be false }
    end

    context 'when spot is not taken' do
      it { is_expected.to be true }
    end
  end

  describe '#display' do
    context 'with board of size 2' do
      let(:size) { 2 }
      
      it 'prints current board' do
        board_2_by_2_structure = <<~BOARD
          \s1 | 2
          ===+===
          \s3 | 4
        BOARD
        expect(board).to receive(:puts).with(board_2_by_2_structure)
        board.display
      end
    end

    context 'with board of size 2' do
      let(:size) { 3 }
      
      it 'prints current board' do
        board_3_by_3_structure = <<~BOARD
          \s1 | 2 | 3
          ===+===+===
          \s4 | 5 | 6
          ===+===+===
          \s7 | 8 | 9
        BOARD
        expect(board).to receive(:puts).with(board_3_by_3_structure)
        board.display
      end
    end
  end

  describe '#fulfilled?' do
    let(:size) { 2 } 
    context 'when each slot has a value on it' do
      before do
        4.times do |i|
          board[i] = i 
        end
      end

      it { expect(board.fulfilled?).to be true }
    end

    context 'when none slot has a value set on it' do
      before do
        4.times { |i| board[i] = nil }
      end

      it { expect(board.fulfilled?).to be false } 
    end

    context 'when at least one slot has a value' do
      before do
        board[0] = 2
      end

      it { expect(board.fulfilled?).to be false } 
    end
  end

  describe '#has_line_with_uniq_value?' do
    let(:size) { 3 }

    context 'when first horizontal line is filled with a uniq value' do
      before do
        [0, 1, 2].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_line_with_uniq_value?).to eq(true) }
    end
    
    context 'when second horizontal line is filled with a uniq value' do
      before do
        [3, 4, 5].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_line_with_uniq_value?).to eq(true) }
    end

    context 'when third horizontal line is filled with a uniq value' do
      before do
        [6, 7, 8].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_line_with_uniq_value?).to eq(true) }
    end

    context 'when first vertical line is filled with a uniq value' do
      before do
        [0, 3, 6].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_line_with_uniq_value?).to eq(true) }
    end

    context 'when second vertical line is filled with a uniq value' do
      before do
        [1, 4, 7].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_line_with_uniq_value?).to eq(true) }
    end

    context 'when third vertical line is filled with a uniq value' do
      before do
        [2, 5, 8].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_line_with_uniq_value?).to eq(true) }
    end

    context 'when first diagonal line is filled with a uniq value' do
      before do
        [0, 4, 8].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_line_with_uniq_value?).to eq(true) }
    end

    context 'when second diagonal line is filled with a uniq value' do
      before do
        [2, 4, 6].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_line_with_uniq_value?).to eq(true) }
    end

    context 'when there is not at least line one uniq value' do
      before do
        ('a'..'i').each_with_index {|letter, index| board[index] = letter }
      end

      it { expect(board.has_line_with_uniq_value?).to eq(false) }
    end
  end
end
