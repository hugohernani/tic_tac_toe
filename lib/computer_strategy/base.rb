module ComputerStrategy
  class Base
    def initialize(board)
      @game_board = board
    end

    def get_choice
      raise NotImplementedError, 'subclass must implement strategy'
    end

    private

    def board
      @game_board.deep_clone
    end
  end
end
