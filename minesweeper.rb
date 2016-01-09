require_relative "board.rb"
require_relative "tile.rb"
require "byebug"

class Minesweeper
  attr_accessor :player

  def initialize(name, size = 9, number_of_bombs = 10)
    @player = name
    @number_of_bombs = number_of_bombs
    @board = Board.new(size, number_of_bombs)
  end

  def play
  end

  def flag
  end

  def unflag
  end

  def reveal
  end

  def lose?
  end

  def win?
  end
end
