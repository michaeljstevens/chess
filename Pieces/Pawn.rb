require_relative 'piece'

class Pawn < Piece

  def symbol
    '♙'
  end

  def moves()
    forward + side
  end

  def forward
    forward_moves = []
    current_x = position[0]
    current_y = position[1]
    if color == :white
      pos = [(current_x - 1), current_y]
      forward_moves << pos if board.valid_pos?(pos) && board.empty?(pos)
      if current_x == 6
        pos = [(current_x - 2), current_y]
        forward_moves << pos if board.valid_pos?(pos) && board.empty?(pos)
      end
    else
      pos = [(current_x + 1), current_y]
      forward_moves << pos if board.valid_pos?(pos) && board.empty?(pos)
      if current_x == 1
        pos = [(current_x + 2), current_y]
        forward_moves << pos if board.valid_pos?(pos) && board.empty?(pos)
      end
    end
    forward_moves
  end

  def side
    current_x = position[0]
    current_y = position[1]

    if color == :white
      diags = [[(current_x - 1), (current_y - 1)], [(current_x - 1), (current_y + 1)]]
    else
      diags = [[(current_x + 1), (current_y + 1)], [(current_x + 1), (current_y - 1)]]
    end
    check_diags(diags)
  end

  def check_diags(diags)
    side_moves = []

    diags.each do |diag|
      next unless board.valid_pos?(diag)
      unless board.empty?(diag)
        side_moves << diag if board[diag].color != color
      end
    end
    side_moves
  end

end
