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

  def display_result
    return display_tie_message if @board.tie_result?

    crossed_line = @board.crossed_line
    return unless crossed_line

    display_winner(winning_player(crossed_line.uniq_slot))
  end

  private

  def display_tie_message
    message = <<~MESSAGE
      Game over.
      It's a tie.
    MESSAGE

    puts message
  end

  def winning_player(slot)
    @players.get_player(slot.value)
  end

  def display_winner(player)
    message = <<~MESSAGE
      Game over.
      Winner: #{player}.
    MESSAGE

    puts message
  end
end
