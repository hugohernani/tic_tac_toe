describe Board do
  subject(:board) { described_class.new(size: size, starts_with: starting_at) }

  let(:starting_at) { 1 }

  describe '#apply_next_move' do
    let(:size) { 2 }
    let(:player) { HumanPlayer.new(sign: 'X') }
    let(:mock_input) { "1\n" }

    before do
      allow(player).to receive(:gets).and_return(mock_input)
    end

    it "assign player' sign into selected slot when move is valid" do
      board.apply_next_move(player)

      parsed_input = mock_input.chomp.to_i
      expect(board[parsed_input].value).to eq 'X'
    end
  end

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
          board[i + 1] = i 
        end
      end

      it { expect(board.fulfilled?).to be true }
    end

    context 'when none slot has a value set on it' do
      before do
        4.times { |i| board[i + 1] = nil }
      end

      it { expect(board.fulfilled?).to be false } 
    end

    context 'when at least one slot has a value' do
      before do
        board[1] = 2
      end

      it { expect(board.fulfilled?).to be false } 
    end
  end

  describe '#has_crossed_line?' do
    let(:size) { 3 }

    context 'when first horizontal line is filled with a uniq value' do
      before do
        [1, 2, 3].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_crossed_line?).to eq(true) }
    end
    
    context 'when second horizontal line is filled with a uniq value' do
      before do
        [4, 5, 6].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_crossed_line?).to eq(true) }
    end

    context 'when third horizontal line is filled with a uniq value' do
      before do
        [7, 8, 9].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_crossed_line?).to eq(true) }
    end

    context 'when first vertical line is filled with a uniq value' do
      before do
        [1, 4, 7].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_crossed_line?).to eq(true) }
    end

    context 'when second vertical line is filled with a uniq value' do
      before do
        [2, 5, 8].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_crossed_line?).to eq(true) }
    end

    context 'when third vertical line is filled with a uniq value' do
      before do
        [3, 6, 9].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_crossed_line?).to eq(true) }
    end

    context 'when first diagonal line is filled with a uniq value' do
      before do
        [1, 5, 9].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_crossed_line?).to eq(true) }
    end

    context 'when second diagonal line is filled with a uniq value' do
      before do
        [3, 5, 7].each {|i| board[i] = 'X' }
      end

      it { expect(board.has_crossed_line?).to eq(true) }
    end

    context 'when there is not at least line one uniq value' do
      before do
        ('a'..'i').each.with_index(starting_at) {|letter, index| board[index] = letter }
      end

      it { expect(board.has_crossed_line?).to eq(false) }
    end
  end
end
