module ComputerStrategies
  module Signing
    ComputerSigns = Struct.new(:first, :second) do
      def to_a
        [first, second]
      end
    end

    private

    def build_signs(board, sign)
      opposite_sign = board.slots.find do |slot|
        slot.value && slot.value != sign
      end&.value

      opposite_sign ||= PlayerSign.new(value: 'O')
      ComputerSigns.new(sign, opposite_sign)
    end
  end
end
