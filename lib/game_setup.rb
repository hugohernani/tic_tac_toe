class GameSetup
  Info = Struct.new(:board, :players)

  def initialize
    @board = Board.new(size: 3)
    @game_mode = GamingSetup::Mode.new(@board)
  end

  def welcome
    message = <<~MESSAGE
      Welcome to TicTacToe Game!
      Let's have some fun!
    MESSAGE
    puts message
  end

  def start
    @game_mode.choose_message
    @game_mode.ask
    Info.new(@board, @game_mode.build_game_players)
  end
end
