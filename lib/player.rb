class Player
  attr_reader :name, :sign

  def initialize(name:, sign:)
    @name  = name
    @sign  = sign
  end

  def get_move
    raise NotImplementedError, 'subclass should implement movement'
  end
end
