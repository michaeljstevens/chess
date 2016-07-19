require_relative 'piece'
require_relative 'steppable'

class Knight < Piece
  include Slideable

  def symbol
    '♘'
  end

  def move_dirs

  end

end
