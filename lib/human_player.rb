require_relative 'player'

class HumanPlayer < Player
  def get_move
    gets.chomp.to_i
  end
end
