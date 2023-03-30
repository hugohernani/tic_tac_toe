class Game
  def start_game
    setup_game
    loop do
      @game_control.display_board
      @game_control.next_move!
      
      break if @game_control.finished?
    end
    @game_control.display_result 
  end

  private

  def setup_game
    @board = Board.new(size: 3)
    computer_strategy = ComputerStrategy::EagerToWin.new(@board, signs: ['X', 'O'])
    players = GamePlayer.new(
      HumanPlayer.new(sign: 'O'),
      ComputerPlayer.new(sign: 'X', strategy: computer_strategy)
    )
    @game_control = GameControl.new(board: @board, players: players)
  end
end
