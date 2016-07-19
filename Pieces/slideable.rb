require 'byebug'
module Slideable
  DIAGS = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  HORIZ = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  def horizontal_dirs
    HORIZ
  end

  def diagonal_dirs
    DIAGS
  end

  def moves()
    possible_moves = []
    move_dirs.each do |x, y|
      possible_moves += grow_unblocked_moves(x, y)
    end
    possible_moves
  end

  def grow_unblocked_moves(x, y)
    current_x, current_y = position
    moves = []
    while true
      current_x, current_y = current_x + x, current_y + y
      position = [current_x, current_y]
      break unless board.valid_pos?(position)
      if board.empty?(position)
        moves << position
      else
        moves << position if board[position].color != color
        break
      end
    end
    moves
  end

end
