class BoardCell
  def initialize(board)
    @board = board
  end

  def cell_for(spot)
    return unless @board.valid_move?(spot)

    @board[spot]
  end
end
