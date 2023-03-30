module ComputerStrategy
  class EagerToWin < Base
    def initialize(board, signs:)
      super(board)
      @signs = signs
    end

    def get_choice
      board = @board.deep_clone
      available_slots = board.slots.reject(&:taken?)
      computer_choice = best_choice(board, available_slots)
      return computer_choice.index if computer_choice

      available_slots.sample.index
    end

    def best_choice(board, available_slots)
      [computer_sign, human_sign].each do |sign|
        available_slots.each do |slot|
          slot.temporary_assignment(sign) do
            return slot if board.finished?
          end
        end
      end
      
      board.central_slot if central_spot_available_for_first_move?(board)
    end

    def central_spot_available_for_first_move?(board)
      board.first_move? && board.is_central_slot_available?
    end

    def computer_sign
      @signs[0] # X
    end

    def human_sign
      @signs[1] # 0
    end
  end
end
