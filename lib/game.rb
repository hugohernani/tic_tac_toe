Dir.glob(File.join(File.dirname(__FILE__), '**', '*.rb'), &method(:require))

class Game
  def start
    info = GameSetup.new.start
    game_control = GameControl.new(board: info.board, players: info.players)
    run(game_control)
  end

  private

  def run(game_control)
    loop do
      game_control.display_board
      game_control.next_move!
      
      break if game_control.finished?
    end
    game_control.display_result 
  end
end
