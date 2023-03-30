describe Board do
  subject(:board) { described_class.new(size: size, starts_with: starting_at) }

  let(:starting_at) { 1 }
  let(:size) { 3 }

  describe '#deep_clone' do
    it 'builds a new board object' do
      clone_board = Board.new(size: 1).deep_clone

      expect(board).not_to eq(clone_board)
    end
  end

  describe '#apply_next_move' do
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

  describe '#first_move?' do
    context 'when board has none slot filled' do
      it { expect(board.first_move?).to eq true }
    end

    context 'when board has at least one slot filled' do
      before { board[1] = 'X' }

      it { expect(board.first_move?).to eq false }
    end
  end

  describe '#central_slot' do
    context 'with a 3x3 board' do
      let(:size) { 3 }

      it 'gives slot of index 5' do
        expect(board.central_slot.index).to eq 5
      end
    end

    context 'with a 4x4 board' do
      let(:size) { 4 }

      it 'gives slot of index 8' do
        expect(board.central_slot.index).to eq 8
      end
    end
  end

  describe '#has_crossed_line?' do
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
