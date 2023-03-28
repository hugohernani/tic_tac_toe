class Line < Array
  def initialize(*slots)
    super(slots.flatten)
  end

  def crossed?
    !uniq_slot&.value.nil?
  end

  def uniq_slot
    return unless uniq_slots.length == 1

    uniq_slots[0]
  end

  private

  def uniq_slots
    @uniq_slots ||= uniq
  end
end
