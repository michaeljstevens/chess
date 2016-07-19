require_relative 'board'

class Game
  attr_accessor :board, :current_player, :display

  def initialize
    @board = Board.new
    @display = Display.new(board.grid)
    @current_player = :white
  end

  def play
    until checkmate?
      position = @display.get_move
      @board.move(position[0], position[1])
      @display.render
    end
  end

  def checkmate?
    false
  end

end

if __FILE__ == $PROGRAM_NAME
  a = Game.new
  a.play
end
