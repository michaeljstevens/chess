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
  attr_accessor :grid, :current_player

  def initialize
    @grid = Array.new(8) { Array.new (8) }
    @current_player = current_player
    populate
  end

  def switch_player
    if @current_player == :white
      @current_player = :black
    else
      @current_player = :white
    end
  end

  def populate

    grid[0][0] = Rook.new([0,0], self, :black)
    grid[0][1] = Knight.new([0,1], self, :black)
    grid[0][2] = Bishop.new([0,2], self, :black)
    grid[0][3] = King.new([0,3], self, :black)
    grid[0][4] = Queen.new([0,4], self, :black)
    grid[0][5] = Bishop.new([0,5], self, :black)
    grid[0][6] = Knight.new([0,6], self, :black)
    grid[0][7] = Rook.new([0,7], self, :black)
    grid[1].each_index { |idx| grid[1][idx] = Pawn.new([1, idx], self, :black)}
    (2..5).each do |idx1|
      grid[idx1].each_index do |idx2|
        grid[idx1][idx2] = NullPiece.instance
      end
    end
    grid[6].each_index { |idx| grid[6][idx] = Pawn.new([6, idx], self, :white)}
    grid[7][0] = Rook.new([7,0], self, :white)
    grid[7][1] = Knight.new([7,1], self, :white)
    grid[7][2] = Bishop.new([7,2], self, :white)
    grid[7][3] = King.new([7,3], self, :white)
    grid[7][4] = Queen.new([7,4], self, :white)
    grid[7][5] = Bishop.new([7,5], self, :white)
    grid[7][6] = Knight.new([7,6], self, :white)
    grid[7][7] = Rook.new([7,7], self, :white)
  end

  def move(start, end_pos)
    raise "Please choose a piece" if self[start].nil?
    self[start].position = end_pos
    self[end_pos] = self[start]
    self[start] = NullPiece.instance
    unless valid_pos?(end_pos)
      raise "Please choose a valid end position"
    end
  end

  def valid_pos?(pos)
    return true if pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def empty?(pos)
    self[pos].empty?
  end

  def in_check?(color)
    king_pos = find_king(color)
    grid.each do |row|
      row.each do |piece|
        next if piece.is_a?(NullPiece)
        if piece.color != color && piece.moves.include?(king_pos)
          return true
        end
      end
    end
    false
  end

  def checkmate?(color)
    return false unless in_check?(color)
    king_pos = find_king(color)
    grid.each do |row|
      row.each do |piece|
        next if piece.is_a?(NullPiece)
        next if piece.color != color
        return false unless check_moves(piece).empty?
      end
    end
  end

  def check_moves(piece)
    val_origin = piece
    idx_origin = piece.position
    piece.moves.select do |pos|
      val_dest = self[pos]
      idx_dest = pos
      self.move(piece.position, pos)
      is_in_check = in_check?(current_player)
      possible_pos = pos if !is_in_check
      undo(val_origin, idx_origin, val_dest, idx_dest)
      possible_pos ? true : false
    end
  end

  def undo(val_origin, idx_origin, val_dest, idx_dest)
    val_origin.position = idx_origin unless val_origin.is_a?(NullPiece)
    self[idx_origin] = val_origin
    self[idx_dest] = val_dest

  end

  def find_king(color)
    grid.each do |row|
      row.each do |piece|
        if piece.is_a?(King) && piece.color == color
          return piece.position
        end
      end
    end
  end

  def inspect
    @display.render
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
