require_relative 'piece'
require_relative 'steppable'

class King < SteppingPiece
  include Slideable

  def symbol
    '♔'
  end

  def move_dirs
  end

end
