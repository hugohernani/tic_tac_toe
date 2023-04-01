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
        GamePlayer.new(HumanPlayer.new(sign: blue_O_sign), HumanPlayer.new(sign: red_X_sign))
      when :cc
        GamePlayer.new(
          ComputerPlayer.new(sign: blue_O_sign, strategy: strategy_setup.ask(blue_O_sign)),
          ComputerPlayer.new(sign: red_X_sign, strategy: strategy_setup.ask(red_X_sign))
        )
      when :hc
        GamePlayer.new(
          HumanPlayer.new(sign: blue_O_sign),
          ComputerPlayer.new(sign: red_X_sign, strategy: strategy_setup.ask(red_X_sign))
        )
      end
    end

    private
  
    def restart(choice)
      puts "Invalid choice: #{choice}. Please try again"
  
      choose_message
      ask
    end

    def blue_O_sign
      PlayerSign.new(value: 'O', color: 'blue')
    end

    def red_X_sign
      PlayerSign.new(value: 'X', color: 'red')
    end
  end
end
