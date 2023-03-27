class Game
  def initialize
    @board = Board.new(size: 3) 
  end

  def start_game
    setup_players
    until @board.finished?
      @board.display
      @board.ask_player(@players.current)
      @board.apply_next_move(@players.current)
      @players.switch_active!
    end
    @board.display
    puts "Game over"
  end

  private

  def setup_players
    @players = GamePlayer.new(
      HumanPlayer.new(sign: 'O'),
      HumanPlayer.new(sign: 'X')
    )
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end
end
