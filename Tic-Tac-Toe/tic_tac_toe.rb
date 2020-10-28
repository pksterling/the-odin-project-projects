class Game
  def initialize
    puts "Welcome to Tic-Tac-Toe"

    @crosses = Player.new("Crosses", "X")
    @noughts = Player.new("Noughts", "O")
    @round_number = 0
    @@start_order = [@crosses, @noughts]
    @used_tiles = []

    puts "\nInstructions:\nTake turns at placing your symbol ('X' or 'O') in a"\
        " square, attempting to make a three-in-a-row - diagonally"\
        " vertically or horizontally. In order to place a symbol, enter a"\
        " coordinate in the following format: a1, b1, c3, ect.\n\nOkay,"\
        " #{@crosses.name} and #{@noughts.name}, let's play Tic-Tac-Toe!\n\n"
  end

  def print_score
    puts "Score:\n#{@crosses.name} #{@crosses.score} - #{@noughts
    .score} #{@noughts.name}\n\n"
  end

  def play_round
    @round_number += 1
    # Reset used tiles array
    @used_tiles = []
    @board = Board.new
    
    sort_turn_order

    puts "Round #{@round_number} out of 5"

    loop do
      take_turn(@@turn_order[0])
      break if @board.check_winner
    end

    end_round
  end

  def sort_turn_order
    if @crosses.score == @noughts.score
      @@turn_order = @@start_order
    else
      @@turn_order = @@start_order.sort_by { |player| player.score }
    end
    @@start_order = @@turn_order.reverse
  end
  
  def take_turn(player)
    @board.print
    
    coordinates = "x0"
    # Refuses incorrect coordinate format, as well as used coordinates
    until /\A[abc][123]\z/i.match(coordinates) && !@used_tiles.include?(coordinates) do 
      puts "#{player.name}, type your coordinates!"
      coordinates = gets.chomp
    end
    
    @used_tiles.push(coordinates)
    # Change targeted tile from " " to "X" or "O"
    @board.send("#{coordinates}=", player.symbol)
    @@turn_order.reverse!
  end
  
  def end_round
    @board.print
    if @board.check_winner == "draw"
      puts "\nCongratulations, you've achieved absolutely nothing. Draw!"
    else
      if @board.check_winner == "crosses"
        @round_winner = @crosses 
      elsif @board.check_winner == "noughts"
        @round_winner = @noughts
      end
      @round_winner.score += 1
      puts "\nCongratulations, #{@round_winner.name}! You win this round."
    end    
    print_score
  end

  def end_game
    if @crosses.score != @noughts.score
      if @crosses.score > @noughts.score
        @game_winner = @crosses
      elsif @crosses.score < @noughts.score
        @game_winner = @noughts
      end
      puts "Congratulations, #{@game_winner.name}! You win the entire game!!!"
    else
      puts "Brilliant. No one has proved worthy of the title of victor! "\
      "Here's another round to decide upon a winner..."
      play_round
      end_game
    end
    restart
  end

  def restart
    @restart = ""
    puts "After this amazing journey, would you like another game?"
    until @restart == "y" || @restart == "Y" || @restart == "n" ||
      @restart == "N"
      puts "Type 'Y' or 'N'"
      @restart = gets.chomp
    end

    if @restart == "y" ||@restart == "Y"
      current_game = Game.new
      current_game.play_game
    end
  end

  def play_game
    while @round_number < 5 do
      play_round
    end
    end_game
  end
end

class Player
  attr_accessor :name, :score, :symbol

  def initialize(player, symbol)
    puts "#{player} - enter name:"
    @name = gets.chomp
    @score = 0
    @symbol = symbol
  end
end

class Board
  attr_accessor :board, :a1, :a2, :a3, :b1, :b2, :b3, :c1, :c2, :c3

  def initialize
    clear()
    @board = "    a   b   c\n  ┌───┬───┬───┐\n1 │ #{@a1} │ #{@b1} │ #{@c1} │\n  ├───┼───┼───┤\n2 │ #{@a2} │ #{@b2} │ #{@c2} │\n  ├───┼───┼───┤\n3 │ #{@a3} │ #{@b3} │ #{@c3} │\n  └───┴───┴───┘"
  end

  def clear
    @a1 = " "
    @a2 = " "
    @a3 = " "
    @b1 = " "
    @b2 = " "
    @b3 = " "
    @c1 = " "
    @c2 = " "
    @c3 = " "
  end

  def print
    @board = "    a   b   c\n  ┌───┬───┬───┐\n1 │ #{@a1} │ #{@b1} │ #{@c1} │\n  ├───┼───┼───┤\n2 │ #{@a2} │ #{@b2} │ #{@c2} │\n  ├───┼───┼───┤\n3 │ #{@a3} │ #{@b3} │ #{@c3} │\n  └───┴───┴───┘"
    puts @board
  end

  def check_winner
    winning_lines = [[@a1, @a2, @a3], [@b1, @b2, @b3], [@c1, @c2, @c3],
    [@a1, @b1, @c1], [@a2, @b2, @c2], [@a3, @b3, @c3], [@a1, @b2, @c3],
    [@a3, @b2, @c1]]

    winning_lines.each { |line|
      @winner = "crosses" if line.uniq == ["X"]
      @winner = "noughts" if line.uniq == ["O"]
    }

    # Unless a winner has already been found, if none of the tiles are empty
    # then a draw is declared
    unless @winner
      if self.instance_variables.none? { |tile|
        instance_variable_get(tile) == " "
      }
        @winner = "draw"
      end
    end

    @winner
  end
end

current_game = Game.new
current_game.play_game