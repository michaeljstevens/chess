class Piece

  attr_accessor :position, :board, :color

  def initialize(pos, board, color)
    @position = pos
    @board = board
    @color = color
  end

  def to_s
    " #{symbol} "
  end

  def empty?
    false
  end

  def move_into_check(start_pos)
  end

end
