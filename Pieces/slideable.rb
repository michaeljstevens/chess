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
    current_x, current_y = pos
    moves = []
    while true
      current_x, current_y = current_x + dx, current_y + dy
      pos = [current_x, current_y]

      break unless board.valid_pos?(pos)

      if board.empty?(pos)
        moves << pos
      else
        moves << pos if board[pos].color != color
        break
      end
    end
    moves
  end

end
