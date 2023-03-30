require_relative 'player'

class ComputerPlayer < Player
  attr_accessor :strategy

  def initialize(name: 'Computer', strategy:, **kargs)
    super(name: name, **kargs)
    @move_strategy = strategy
  end

  def get_move
    @move_strategy.get_choice
  end
end
