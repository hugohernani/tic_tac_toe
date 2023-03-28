class GamePlayer
  attr_reader :first, :second, :current

  def initialize(first_player, second_player)
    @first = first_player
    @second = second_player
    @current = first_player
  end

  def switch_active!
    if @current == @first
      @current = @second
    else
      @current = @first
    end
  end

  def get_player(sign)
    [ @first, @second ].find do |player|
      player.sign == sign
    end
  end
end
