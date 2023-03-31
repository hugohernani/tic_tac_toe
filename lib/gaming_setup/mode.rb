module GamingSetup
  class Mode
    AVAILABLE_CHOICES = %i( hh cc hc ).freeze

    def initialize(board)
      @board = board
    end
    
    def choose_message
      message = <<~MESSAGE
        Which game mode you would like to choose?
        (hh) Human vs Human
        (cc) Computer vs Computer
        (hc) Human vs Computer
      MESSAGE
      puts message
    end
  
    def ask
      @choice = gets.chomp.strip.split(' ').first&.to_sym
      return if AVAILABLE_CHOICES.include?(@choice)
  
      restart
    end
  
    def build_game_players
      strategy_setup = GamingSetup::ChooseStrategy.new(@board)
      case @choice
      when :hh
        GamePlayer.new(HumanPlayer.new(sign: 'O'), HumanPlayer.new(sign: 'X'))
      when :cc
        GamePlayer.new(
          ComputerPlayer.new(sign: 'O', strategy: strategy_setup.ask('O')),
          ComputerPlayer.new(sign: 'X', strategy: strategy_setup.ask('X'))
        )
      when :hc
        GamePlayer.new(
          HumanPlayer.new(sign: 'O'),
          ComputerPlayer.new(sign: 'X', strategy: strategy_setup.ask('X'))
        )
      end
    end

    private
  
    def restart(choice)
      puts "Invalid choice: #{choice}. Please try again"
  
      choose_message
      ask
    end
  end
end
