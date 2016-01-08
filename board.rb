class Board
  attr_reader :board
  require 'byebug'

  def initialize(size = 9, bombs = 10)
    @size   = size
    @board  = Array.new(size) {Array.new(size)}
    @bombs  = bombs
    board_populate
  end

  private
  def board_populate
    bombs_placed = 0
    until bombs_placed == @bombs
      #debugger
      random_position = [rand(@size), rand(@size)]
      p random_position
      if self[random_position].nil?
        self[random_position] = "B"
      else
        redo
      end
      bombs_placed += 1
    end
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @board[x][y] = value
  end

  def empty?(pos)
    self[pos].nil?
  end
end
