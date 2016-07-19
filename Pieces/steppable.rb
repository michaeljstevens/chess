module Steppable

KING_MOVES = [[1,0], [0,1], [1,1], [-1,0], [0,-1], [-1,-1], [1,-1], [-1,1]]
KNIGHT_MOVES = [[2,1], [1,2], [-2,-1], [-1,-2], [-2,1], [2,-1], [-1,2], [1,-2]]

def king_moves
  KING_MOVES
end

def knight_moves
  KNIGHT_MOVES
end

def moves()
  possible_moves = []
  move_dirs.each do |x, y|
    current_x, current_y = position
    position = [current_x + x, current_y + y]

    next unless board.valid_pos?(position)

    if board.empty?(position)
      possible_moves << position
    elsif board[position].color != color
      possible_moves << position
    end
  end
  possible_moves
end




end
