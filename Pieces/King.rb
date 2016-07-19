require_relative 'piece'
require_relative 'steppable'

class King < Piece
  include Steppable

  def symbol
    '♔'
  end

  def move_dirs
    king_moves
  end

end
