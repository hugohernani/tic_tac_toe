class GameControl
  extend Forwardable

  def_delegator :@board, :display, :display_board
  def_delegators :@board, :finished?

  def initialize(board:, players:)
    @board = board
    @players = players
  end

  def next_move! 
    @board.ask_player(@players.current)
    @board.apply_next_move(@players.current)
    @players.switch_active!
  end
end
