describe ComputerStrategy::MindfulMovement do
  subject(:strategy) { described_class.new(board, signs: signs) }

  let(:board) { Board.new(size: 3) }
  let(:signs) { ['H', 'C'] } # (H)uman vs (C)omputer

  describe '#get_choice' do
    context 'when there is no winning movement for any player' do
      # C | 2 | 3
      # 4 | H | 6
      # 7 | C | H
      before do
        board[1] = 'C'
        board[5] = 'H'
        board[8] = 'C'
        board[9] = 'H'
      end

      it 'gives an index of any of the available spots', :aggregate_failures do
        available_spots = board.slots.filter_map{ |s| s.index unless s.value }

        computer_choice = strategy.get_choice
        expect(computer_choice).to be_a(Integer)
        expect(available_spots).to include(computer_choice)
      end
    end

    context "when there is winning movement for 'H' human player" do
      # H | H | 3
      # C | 5 | 6
      # C | 8 | 9
      before do
        board[1] = 'H'
        board[2] = 'H'
        board[4] = 'C'
        board[7] = 'C'
      end

      it "gives to computer the spot so it avoids human's victory" do
        expect(strategy.get_choice).to eq(3)
      end
    end

    context "when there is winning movement for 'C' computer player" do
      # C | 2 | 3
      # H | C | 6
      # H | 8 | 9
      before do
        board[1] = 'C'
        board[5] = 'C'
        board[4] = 'H'
        board[7] = 'H'
      end

      it "gives to computer the spot for winning the game" do
        expect(strategy.get_choice).to eq(9)
      end
    end

    context "when both players are up to choose the winning spot" do
      # 1 | C | 3
      # H | C | 6
      # H | 8 | 9
      before do
        board[2] = 'C'
        board[5] = 'C'
        board[4] = 'H'
        board[7] = 'H'
      end

      it "only blocks human of winning by giving its winning spot to computer" do
        some_attempts = [
          strategy.get_choice,
          strategy.get_choice,
          strategy.get_choice
        ]
        expect(some_attempts.uniq).to eq([1])
      end
    end
  end
end
