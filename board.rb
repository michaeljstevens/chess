require 'byebug'
require_relative 'Pieces/piece'
require_relative 'Pieces/Rook'
require_relative 'Pieces/Bishop'
require_relative 'Pieces/Knight'
require_relative 'Pieces/Pawn'
require_relative 'Pieces/Queen'
require_relative 'Pieces/King'
require_relative 'Pieces/Null'
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
    position = @display.get_move
    move(position[0], position[1])
    @display.render
  end


  def populate

    grid[0][0] = Rook.new([0,0], grid, :black)
    grid[0][1] = Knight.new([0,1], grid, :black)
    grid[0][2] = Bishop.new([0,2], grid, :black)
    grid[0][3] = Queen.new([0,3], grid, :black)
    grid[0][4] = King.new([0,4], grid, :black)
    grid[0][5] = Bishop.new([0,5], grid, :black)
    grid[0][6] = Knight.new([0,6], grid, :black)
    grid[0][7] = Rook.new([0,7], grid, :black)
    grid[1].each_index { |idx| grid[1][idx] = Pawn.new([1, idx], grid, :black)}
    (2..5).each do |idx1|
      grid[idx1].each_index do |idx2|
        grid[idx1][idx2] = NullPiece.instance
      end
    end
    grid[6].each_index { |idx| grid[6][idx] = Pawn.new([6, idx], grid, :white)}
    grid[7][0] = Rook.new([7,0], grid, :white)
    grid[7][1] = Knight.new([7,1], grid, :white)
    grid[7][2] = Bishop.new([7,2], grid, :white)
    grid[7][3] = Queen.new([7,3], grid, :white)
    grid[7][4] = King.new([7,4], grid, :white)
    grid[7][5] = Bishop.new([7,5], grid, :white)
    grid[7][6] = Knight.new([7,6], grid, :white)
    grid[7][7] = Rook.new([7,7], grid, :white)
  end

  def move(start, end_pos)
    raise "Please choose a piece" if self[start].nil?
    self[start].position = end_pos
    self[end_pos] = self[start]
    self[start] = "         nullpiece       "
    unless valid_pos?(end_pos)
      raise "Please choose a valid end position"
    end
  end

  def valid_pos?(pos)
    return true if pos[0].between?(0,7) && pos[1].between?(0,7)
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
