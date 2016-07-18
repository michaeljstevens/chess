require 'byebug'
require_relative 'piece'
require_relative 'display'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new (8) }
    @display = Display.new(grid)
    populate
    render
  end

  def render
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end

  def populate
    [0,1,6,7].each do |idx1|
      grid[idx1].each_index do |idx2|
        grid[idx1][idx2] = Piece.new([idx1, idx2])
      end
    end
  end

  def move(start, end_pos)
    raise "Please choose a piece" if self[start].nil?
    self[start].position = end_pos
    self[end_pos] = self[start]
    self[start] = nil
    unless end_pos[0].between?(0,7) && end_pos[1].between?(0,7)
      raise "Please choose a valid end position"
    end
  end

  def[](pos)
    x, y = pos
    grid[x][y]
  end

  def[]=(pos, value)
    x, y = pos
    grid[x][y] = value
  end
end

if __FILE__ == $PROGRAM_NAME
  a = Board.new
end
