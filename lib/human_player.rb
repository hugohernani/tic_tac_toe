require_relative 'player'

class HumanPlayer < Player
  def initialize(name: 'Human', **kargs)
    super(name: name, **kargs)
  end

  def get_move
    gets.chomp.to_i
  end
end
