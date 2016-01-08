class Tile
  attr_reader :bomb
  attr_accessor :revealed

  def initialize(bomb = false)
    @bomb = bomb
    @revealed = false
  end

  def reveal
    @revealed = true
  end
end
