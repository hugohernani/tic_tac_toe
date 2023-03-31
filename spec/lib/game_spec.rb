describe Game do
  subject(:game) { described_class.new }

  describe '#start' do
    let(:game_info) { instance_double('GameSetup::Info', board: nil, players: nil) }
    let(:game_setup) { instance_double('GameSetup', start: game_info) }
    let(:game_control) { instance_double('GameControl', display_board: nil, next_move!: nil,
                                                        finished?: true, display_result: nil,
                                                        clear_screen: nil) }

    before do
      allow(GameSetup).to receive(:new).and_return(game_setup)
      allow(GameControl).to receive(:new).and_return(game_control)
    end

    it 'delegates setting up game to GameSetup' do
      game.start

      expect(game_setup).to have_received(:start).with(no_args)
    end

    it 'displays the board through game controller' do
      game.start

      expect(game_control).to have_received(:display_board).with(no_args)
    end

    it 'asks for next movement on game controller' do
      game.start

      expect(game_control).to have_received(:next_move!).with(no_args)
    end

    it 'checks for state of then game with finished on game controller' do
      game.start

      expect(game_control).to have_received(:finished?).with(no_args)
    end

    it 'displays the result of the game through game controller' do
      game.start

      expect(game_control).to have_received(:display_result).with(no_args)
    end

    context 'when game is not finished yet' do
      let(:unfinished_loops) { 4 }
      let(:all_loop_counts) { unfinished_loops + 1 }

      before do
        # with last finished step
        loop_turns = Array.new(unfinished_loops) << true 
        allow(game_control).to receive(:finished?).and_return(*loop_turns)
      end

      it 'displays board up to game has finished' do
        game.start

        expect(game_control).to have_received(:display_board).exactly(all_loop_counts).times
      end

      it 'asks the next move up to game has finished' do
        game.start

        expect(game_control).to have_received(:next_move!).exactly(all_loop_counts).times
      end
    end
  end
end
