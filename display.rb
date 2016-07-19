require 'colorize'
require_relative 'cursorable'
require_relative 'board'

class Display
  include Cursorable

  attr_accessor :board

  def initialize(board)
    @board = board
    @cursor_pos = [6,4]
    @selected = false
  end

  def get_input
    handle_input
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j, piece)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j, piece)
    if [i, j] == @cursor_pos
      bg = :blue
    elsif (i + j).odd?
      bg = :light_red
    else
      bg = :light_black
    end
    { background: bg, color: piece.color }
  end

  def get_move
    start_pos = nil
    end_pos = nil
    render
    while true
      while start_pos.nil?
        render
        start_pos = get_input
      end
      while end_pos.nil?
        render
        end_pos = get_input
      end
      return [start_pos, end_pos]
    end
  end

  def render
    system("clear")
    puts "#{@board.current_player.upcase}'s Turn"
    if @board.in_check?(@board.current_player)
      puts "#{(@board.current_player).upcase} is in check!"
    end
    build_grid.each { |row| puts row.join }
  end

end
