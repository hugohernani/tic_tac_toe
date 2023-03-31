module GamingSetup
  class ChooseStrategy
    AVAILABLE_CHOICES = %i( e m h ).freeze

    def initialize(board)
      @board = board
    end

    def ask(sign)
      print_message(sign)
      choice = gets.chomp.strip.split(' ').first&.to_sym
      return strategy_for(choice, sign) if AVAILABLE_CHOICES.include?(choice)

      puts "Invalid choice: #{choice}. Try again"
      ask(sign)
    end

    private

    def print_message(sign)
      message = <<~MESSAGE
        Choose which strategy you would like to set
        for computer with sign of #{sign}:
        (e) Easy mode. Spot is chosen randomly
        (m) Medium mode. Spot is initially chosen wisely
        (h) Hard mode. Spot is chosen with victory in mind
      MESSAGE
      puts message
    end

    def strategy_for(choice, sign)
      case choice
      when :e
        ComputerStrategy::Random.new(@board)
      when :m
        ComputerStrategy::MindfulMovement.new(@board, sign: sign)
      when :h
        ComputerStrategy::EagerToWin.new(@board, sign: sign)
      end
    end

    def random_strategy
      @random_strategy ||= ComputerStrategy::Random.new(@board)
    end
  end
end
