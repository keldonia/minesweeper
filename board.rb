class Board
  require_relative 'tile.rb'

  attr_reader :grid
  require 'byebug'

  def initialize(size, bombs)
    @size   = size
    @grid  = Array.new(size) { Array.new(size) }
    #@revealed_pos = []
    @bombs  = bombs
    board_populate
    # board_state
  end

  def board_render
    system 'clear'
    (0...@size).to_a.each do |x|
      line = ""
      (0...@size).to_a.each do |y|
        pos = [x,y]
        bombs_adjacent = bomb_adjacency(pos)

        if self[pos].revealed == false
          line << "*"
        elsif self[pos].bomb
          line << "B"
        elsif bombs_adjacent == 0
          line << "_"
        elsif self[pos].flagged
          line << "F"
        else
          line << bombs_adjacent.to_s
        end

        line << "|" unless y == @size - 1
      end
      print line
      puts "\n"
    end
  end

  def reveal_tiles(pos)
    return  if self[pos].revealed
    self[pos].reveal
    return  if bomb_adjacency(pos) != 0
    return :B if self[pos].bomb

    bordering_tiles(pos).each do |tile|
      reveal_tiles(tile)
    end
  end

  private

  # def board_state
  #   (0...@size).to_a.each do |x|
  #     (0...@size).to_a.each do |y|
  #       pos = [x,y]
  #       self[pos] = bomb_adjacency(pos) unless self[pos].bomb
  #     end
  #   end
  # end

  def bomb_adjacency(pos)
    number_of_bombs_adjacent = 0

    bordering_tiles(pos).each do |tile|
      number_of_bombs_adjacent += 1 if self[tile].bomb
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


  # def board_populate
  #   bombs_placed = 0
  #
  #   until bombs_placed == @bombs
  #     #debugger
  #     random_position = [rand(@size), rand(@size)]
  #     if self[random_position].nil?
  #       self[random_position] = :B
  #     else
  #       redo
  #     end
  #     bombs_placed += 1
  #   end
  # end

  def board_populate
    tiles = []

    @bombs.times do |bomb|
      tiles << Tile.new(true)
    end

    ((@size * @size) - @bombs).times do |tile|
      tiles << Tile.new
    end

    tiles.shuffle!

    (0...@size).to_a.each do |x|
      (0...@size).to_a.each do |y|
        pos = [x, y]
        self[pos] = tiles.pop
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end
end
