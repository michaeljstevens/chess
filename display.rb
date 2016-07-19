require 'colorize'
require_relative 'cursorable'
require_relative 'board'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = false
  end

  def get_input
    handle_input
  end

  def build_grid
    @board.map.with_index do |row, i|
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
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg, color: piece.color }
  end

  def get_move
    start_pos = nil
    end_pos = nil
    while true
      render
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
    build_grid.each { |row| puts row.join }
  end

end
