class Slot
  attr_accessor :index, :value

  def initialize(index)
    @index = index
    @value = nil
  end

  def to_s
    @value ? @value.to_s : index.to_s
  end

  def inspect
    to_s
  end
end
