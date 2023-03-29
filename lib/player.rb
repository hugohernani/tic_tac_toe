class Player
  attr_reader :name, :sign

  def initialize(name:, sign:, **kargs)
    @name  = name
    @sign  = sign
  end

  def to_s
    "#{@name}(#{@sign})"
  end

  def get_move
    raise NotImplementedError, 'subclass should implement movement'
  end
end
