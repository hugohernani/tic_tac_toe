class Line < Array
  def initialize(*slots)
    super(slots.flatten)
  end

  def crossed?
    uniq_slots = uniq
    uniq_slots.length == 1 && !uniq_slots[0].value.nil?
  end
end
