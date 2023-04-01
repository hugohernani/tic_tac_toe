describe ComputerStrategy::MindfulMovement do
  subject(:strategy) { described_class.new(board, sign: computer_sign) }

  let(:board) { Board.new(size: 3) }
  let(:computer_sign) { PlayerSign.new(value: 'C', color: 'red') } # (C)omputer vs (?)Human
  let(:human_sign) { PlayerSign.new(value: 'H', color: 'blue') }

  describe '#get_choice' do
    context 'when there is no winning movement for any player' do
      # C | 2 | 3
      # 4 | H | 6
      # 7 | C | H
      before do
        board[1] = computer_sign
        board[5] = human_sign
        board[8] = computer_sign
        board[9] = human_sign
      end

      it 'gives an index of any of the available spots', :aggregate_failures do
        available_spots = board.slots.filter_map{ |s| s.index unless s.value }

        computer_choice = strategy.get_choice
        expect(computer_choice).to be_a(Integer)
        expect(available_spots).to include(computer_choice)
      end
    end

    context "when there is winning movement for 'O' human player" do
      # H | H | 3
      # C | 5 | 6
      # C | 8 | 9
      before do
        board[1] = human_sign
        board[2] = human_sign
        board[4] = computer_sign
        board[7] = computer_sign
      end

      it "gives to computer the spot so it avoids human's victory" do
        expect(strategy.get_choice).to eq(3)
      end
    end

    context "when there is winning movement for computer_sign computer player" do
      # C | 2 | 3
      # H | C | 6
      # H | 8 | 9
      before do
        board[1] = computer_sign
        board[5] = computer_sign
        board[4] = human_sign
        board[7] = human_sign
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
        board[2] = computer_sign
        board[5] = computer_sign
        board[4] = human_sign
        board[7] = human_sign
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
