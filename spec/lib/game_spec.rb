require_relative '../spec_helper'

describe Game do
  subject(:game) { described_class.new }

  describe '#start_game' do

    it "prints game board" do
      mock_input = "1\n"

      allow(game).to receive(:gets).and_return(mock_input)

      expect(game.start_game).to eq("1")
    end
  end
end
