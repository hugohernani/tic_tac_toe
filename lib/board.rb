require_relative 'game_board/cloneable.rb'

class Board
  include GameBoard::Cloneable

  attr_reader :slots

  def initialize(size:3, starts_with: 1)
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
    spot = player.get_move
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

  def tie_result?
    return false if has_crossed_line?

    fulfilled?
  end

  def finished?
    fulfilled? || has_crossed_line?
  end

  def fulfilled?
    @slots.none? { |slot| slot.value.nil? }
  end

  def first_move?
    @slots.all? { |slot| slot.value.nil? }
  end

  def is_central_slot_available?
    !central_slot.taken?
  end

  def central_slot
    @central_slot ||= begin
      left_half_size = ((@slots.size - 1) / 2)
      right_half_size = (@slots.size / 2)
    
      median = (left_half_size + right_half_size) / 2
      self[median + 1]
    end
  end

  def has_crossed_line?
    !!crossed_line
  end
  
  def crossed_line
    [
      horizontal_lines,
      vertical_lines,
      diagonal_lines
    ].flatten(1).find(&:crossed?)
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
