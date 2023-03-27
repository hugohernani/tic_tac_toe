class Board
  def initialize(size:3, starts_with: 1)
    @size  = size
    @slots = Array.new(size * size) do |index|
      Slot.new(index + starts_with)
    end
  end

  def [](index)
    @slots[index]
  end
  alias_method :value_at, :[]

  def []=(index, value)
    @slots[index].value = value
  end
  alias_method :fill_with, :[]= 

  def valid_move?(spot)
    @slots[spot] && !@slots[spot].taken?
  end

  def display
    rows = @slots.each_slice(@size).map do |slot_group|
      slot_group.join(" | ")
    end
    puts " " + rows.join(row_delimiter) + "\n"
  end

  def fulfilled?
    @slots.none? { |slot| slot.value.nil? }
  end

  def has_line_with_uniq_value?
    [ horizontal_lines, vertical_lines, diagonal_lines ].any? do |lines|
      lines.any?(&:uniq?)
    end
  end

  private

  def row_delimiter
    line_symbol = "==="
    separator_symbol = "+"
    line = Array.new(@size) { line_symbol }.join(separator_symbol)

    "\n#{line}\n "
  end

  def horizontal_lines
    @slots.each_slice(3).map { |slots| Line.new(*slots) } 
  end

  def vertical_lines
    (0...(@size * @size)).step(@size).each_slice(3).map do |slot_indices|
      Line.new(@slots.values_at(*slot_indices))
    end
  end

  def diagonal_lines
    [
      Line.new(@slots.values_at(0, 4, 8)),
      Line.new(@slots.values_at(2, 4, 6))
    ]
  end
end
