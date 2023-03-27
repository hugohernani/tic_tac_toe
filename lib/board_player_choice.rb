class BoardPlayerChoice
  def initialize(board)
    @board = board
  end

  def get_move_for(player)
    player.get_move
  end
end
