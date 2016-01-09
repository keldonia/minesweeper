class Tile
  attr_reader :bomb
  attr_accessor :revealed, :flagged

  def initialize(bomb = false)
    @bomb = bomb
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def flag
    @flagged = true
  end

  def unflag
    @flagged = false
  end
end
