class Board
  def initialize(size:3, starts_with: 1)
    @board_player = BoardPlayerChoice.new(self)
    @size  = size
    @slots = Array.new(size * size) do |index|
      Slot.new(index + starts_with)
    end
    @starting_at = starts_with
  end

  def [](index)
    @slots.find { |slot| slot.index == index }
  end
  alias_method :value_at, :[]

  def []=(index, value)
    self[index].value = value
  end
  alias_method :fill_with, :[]= 

  def apply_next_move(player)
    spot = @board_player.get_move_for(player)
    try_next_move_again(player) unless valid_move?(spot)

    self[spot] = player.sign
  end

  def valid_move?(spot)
    slot = self[spot]
    slot && !slot.taken?
  end

  def display
    rows = @slots.each_slice(@size).map do |slot_group|
      slot_group.join(" | ")
    end
    puts " #{rows.join(row_delimiter)}\n"
  end

  def ask_player(player)
    puts "It's #{player}'s turn. #{choice_prompt_message}"
  end

  def finished?
    fulfilled? || has_crossed_line?
  end

  def fulfilled?
    @slots.none? { |slot| slot.value.nil? }
  end

  def has_crossed_line?
    [ horizontal_lines, vertical_lines, diagonal_lines ].any? do |lines|
      lines.any?(&:crossed?)
    end
  end

  private

  def try_next_move_again(player)
    puts "Invalid choice. Try again: #{choice_prompt_message}"

    apply_next_move(player)
  end

  def choice_prompt_message
    "Enter [#{@starting_at}-#{@size * @size}]:"
  end

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
    @size.times.map do |i|
      slot_indices = [i, i + @size, i + @size * 2]
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
