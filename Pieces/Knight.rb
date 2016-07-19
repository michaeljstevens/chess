require_relative 'piece'
require_relative 'steppable'

class Knight < Piece
  include Steppable

  def symbol
    '♘'
  end

  def move_dirs
    knight_moves
  end

end
