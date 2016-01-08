class Board
  attr_reader :board
  require 'byebug'

  def initialize(size = 9, bombs = 10)
    @size   = size
    @board  = Array.new(size) { Array.new(size) }
    @revealed_pos = []
    @bombs  = bombs
    board_populate
    board_state
  end

  def revealed_board
  end

  def board_state
    (0...@size).to_a.each do |x|
      (0...@size).to_a.each do |y|
        pos = [x,y]
        self[pos] = bomb_adjacency(pos) unless self[pos] == :B
      end
    end
  end

  def bomb_adjacency(pos)
    number_of_bombs_adjacent = 0

    bordering_tiles(pos).each do |tile|
      number_of_bombs_adjacent += 1 if self[tile] == :B
    end

    number_of_bombs_adjacent
  end

  def bordering_tiles(pos)
    possible_border_tiles(pos).select do |pos|
      (0...@size).include?(pos[0]) && (0...@size).include?(pos[1])
    end
  end

  def possible_border_tiles(pos)
    potential_bordering_tiles = []

    (-1..1).to_a.each do |x|
      (-1..1).to_a.each do |y|
        potential_tile = [pos[0] + x, pos[1] + y]
        potential_bordering_tiles << potential_tile unless potential_tile == pos
      end
    end

    potential_bordering_tiles
  end

  private
  def board_populate
    bombs_placed = 0

    until bombs_placed == @bombs
      #debugger
      random_position = [rand(@size), rand(@size)]
      if self[random_position].nil?
        self[random_position] = :B
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
end
