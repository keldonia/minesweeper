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
    #ask for size of board? maybe?
    #ask for number of bombs
    @board.board_render
    puts "\n"
    puts "Would you like to reveal, flag, unflag a tile? (r,f,u)"
    until win? || lose?
      input = STDIN.gets.chomp.downcase

      if input == "r"
        reveal
      elsif input == "f"
        flag
      elsif input == "u"
        unflag
      else
        puts "Please enter a valid command, #{@player}!"
      end
    end
  end

  def flag
    puts "Please input a position to flag, eg. 1,3 :"
    print ">"
    until true
      input = STDIN.gets.chomp.split(",")

      if (0...@size).include?(input[0]) && (0...@size).include?(input[1])
        break
      else
        puts "Please enter a valid position, #{@player}!"
      end
    end

    @board[input].flag
  end

  def unflag
    puts "Please input a position to unflag, eg. 1,3 :"
    print ">"
    until true
      input = STDIN.gets.chomp.split(",")

      if (0...@size).include?(input[0]) && (0...@size).include?(input[1])
        break
      else
        puts "Please enter a valid position, #{@player}!"
      end
    end

    @board[input].unflag
  end

  def reveal
    puts "Please input a position to reveal, eg. 1,3 :"
    print ">"
    until true
      input = STDIN.gets.chomp.split(",")

      if (0...@size).include?(input[0]) && (0...@size).include?(input[1])
        break
      else
        puts "Please enter a valid position, #{@player}!"
      end
    end

    @board.reveal_tiles(input)
    win?
    lose?(input)
  end

  def lose?(input)
    if @board[input].bomb
      @board.board_render
      puts "You lose, #{@player}!"
    end
  end

  def win?
    @board.grid.flatten.each do |tile|
      if @board[tile].revealed || @board[tile].bomb
        @board.board_render
        puts "You won the game, #{@player}!  Congrats on keeping all your limbs!"
      end
    end
  end
end
