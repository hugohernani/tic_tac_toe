module GameBoard
  module Cloneable
    def deep_clone
      clone_board = clone.tap do |board|
        board.instance_variable_set(:@slots, cloned_slots(board))
      end
    end

    private

    def cloned_slots(board)
      board.instance_variable_get(:@slots).clone.tap do |slots|
        slots.map!(&:clone)
      end
    end
  end
end
