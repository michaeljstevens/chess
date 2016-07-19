require_relative 'board'

class Game
  attr_accessor :board, :current_player, :display

  def initialize
    @board = Board.new(:white)
    @display = Display.new(board)
  end

  def play
    until board.checkmate?
      display.render
      position = @display.get_move
      piece = @board[position[0]]
      if piece.moves.include?(position[1])
        @board.move(position[0], position[1])
      end
      @display.render
      @board.switch_player
    end
    puts "Checkmate! #{current_player.upcase} loses."
  end


  def inspect
    @display.render
  end

end

if __FILE__ == $PROGRAM_NAME
  a = Game.new
  a.play
end
