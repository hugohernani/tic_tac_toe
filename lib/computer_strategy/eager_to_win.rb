module ComputerStrategy
  class EagerToWin < Base
    include ComputerStrategies::Signing
    
    def initialize(board, sign:)
      super(board)
      @signs = build_signs(board, sign)
    end

    def get_choice
      board = @board.deep_clone
      available_slots = board.slots.reject(&:taken?)
      computer_choice = best_choice(board, available_slots)
      return computer_choice.index if computer_choice

      available_slots.sample.index
    end

    def best_choice(board, available_slots)
      @signs.to_a.each do |sign|
        available_slots.each do |slot|
          slot.temporary_assignment(sign) do
            return slot if board.finished?
          end
        end
      end
      
      board.central_slot if central_spot_available_for_first_move?(board)
    end

    def central_spot_available_for_first_move?(board)
      board.is_central_slot_available?
    end
  end
end
