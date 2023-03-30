module ComputerStrategy
  class Base
    def initialize(board, **kargs)
      @board = board
    end

    def get_choice
      raise NotImplementedError, 'subclass must implement strategy'
    end
  end
end
