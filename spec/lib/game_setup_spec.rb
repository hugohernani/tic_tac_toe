describe GameSetup do
  subject(:setup) { described_class.new }

  describe '#welcome' do
    it 'prints a welcome message' do
      expect(setup).to receive(:puts).with(/Welcome/)

      setup.welcome
    end
  end

  describe '#start' do
    let(:mode_setup) { instance_double('GamingSetup::Mode', choose_message: nil, ask: nil, build_game_players: nil) }
    
    before do
      allow(GamingSetup::Mode).to receive(:new).and_return(mode_setup)
    end

    it 'delegates choosing mode to game_mode object', :aggregate_failures do
      setup.start

      expect(mode_setup).to have_received(:choose_message)
      expect(mode_setup).to have_received(:ask)
      expect(mode_setup).to have_received(:build_game_players)
    end
  end
end
