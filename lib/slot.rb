class Slot
  attr_accessor :index, :value

  def initialize(index, value: nil)
    @index = index
    @value = value 
  end

  def temporary_assignment(new_value)
    current_value = @value
    @value = new_value
    yield if block_given?
    @value = current_value
  end

  def taken?
    !!@value
  end

  def to_s
    @value ? @value.to_s : @index.to_s
  end

  def ==(other)
    @value == other.value
  end

  def eql?(other)
    @value.eql?(other.value)
  end

  def hash
    @value.hash
  end
end
