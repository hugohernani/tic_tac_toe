require 'colorize'

class PlayerSign
  attr_reader :value, :color

  def initialize(value:, color: color_sample)
    @value = value
    @color = color
  end

  def to_s
    colorized
  end

  def colorized
    @colorized ||= @value.public_send(@color)
  end

  def ==(other)
    @value == other.value
  end

  def eql?(other)
    @value.eql?(other.value)
  end

  def inspect
    @value
  end

  def hash
    @value.hash
  end

  private

  def color_sample
    ['red', 'blue'].sample
  end
end
