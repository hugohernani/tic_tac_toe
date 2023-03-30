module ComputerStrategy
  class MindfulMovement < Base
    def initialize(board, signs:)
      super(board)
      @signs = signs
    end

    def get_choice
      board = @board.deep_clone
      available_slots = board.slots.reject(&:taken?)

      available_slots.each do |slot|
        return slot.index if wins_with?(board, slot)
      end
      
      available_slots.sample.index
    end

    def wins_with?(board, slot)
      @signs.any? do |sign|
        slot.temporary_assignment(sign) do
          return true if board.finished?
        end
      end
    end
  end
end
