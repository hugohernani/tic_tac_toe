class Line < Array
  def initialize(*slots)
    super(slots.flatten)
  end

  def uniq?
    uniq.length == 1
  end
end
