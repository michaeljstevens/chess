require_relative 'board'

class Game
  attr_accessor :board, :current_player, :display

  def initialize
    @board = Board.new
    @display = Display.new(board)
    @current_player = :white
  end

  def play
    until board.checkmate?(@current_player)
      display.render
      position = @display.get_move
      piece = @board[position[0]]
      if piece.moves.include?(position[1])
        @board.move(position[0], position[1])
      end
      @display.render
    end
  end


  def inspect
    @display.render
  end

end

if __FILE__ == $PROGRAM_NAME
  a = Game.new
  a.play
end
