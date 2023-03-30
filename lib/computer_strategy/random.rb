module ComputerStrategy
  class Random < Base
    def get_choice
      available_slots = @board.slots.reject(&:taken?)
      available_slots.sample.index
    end
  end
end
