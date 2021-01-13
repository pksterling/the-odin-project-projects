require 'json'

@@dictionary = File.readlines('dictionary.txt', chomp:true).filter{ |word|
  word.length >= 5 && word.length <= 12
}

class Game
  def initialize
    puts "Welcome to Hangman!"
    puts "Enter 'l' to load"
    
    @player = Player.new
    @answer = Answer.new
    
    load_game() if gets.chomp.downcase == "l"
  end

  def play_round
    remaining_guesses = 10 -
        @player.previous_guesses.length + 
        @answer.correct_guesses
    if remaining_guesses > 0 
      puts "Current board: #{@answer.current_board}"
      puts "Previous guesses: #{@player.previous_guesses.join(", ")}"
      puts "Remaining guesses: #{remaining_guesses}"
      puts "Enter 's' to save"
      save_game() if gets.chomp.downcase == "s"
      puts "Correct" if @answer.process_guess(@player.guess)
      unless @answer.remaining_letters.length == 0
        play_round()
      else
        puts "#{@answer.current_board}"
        puts "Congrats, you guessed the answer was #{@answer.word.upcase}"
      end
    else
      puts "GAME OVER"
      puts "Final board: #{@answer.current_board}"
      puts "Answer: #{@answer.word.upcase}"
    end
  end

  def save_game
    game_state = {
      :answer => @answer.word,
      :previous_guesses => @player.previous_guesses.join("")
    }
    File.open("hangman_save.txt","w+") do |file|
      file.write game_state.to_json
    end
  end

  def load_game
    game_state = JSON.parse(File.read("hangman_save.txt"))
    @player = Player.new(game_state["previous_guesses"])
    @answer = Answer.new(game_state["answer"])
    @player.previous_guesses.each { |guess| @answer.process_guess(guess) }
  end
    
  class Player
    attr_reader :previous_guesses

    def initialize(previous_guesses = "")
      @previous_guesses = previous_guesses.split("")
    end

    def guess
      guess = ""
      until /^[a-zA-Z]$/.match?(guess)
        p "Please input your guess (aA-zZ)..."
        guess = gets.chomp.downcase
      end
      @previous_guesses.push(guess).uniq!
      guess
    end
  end

  class Answer
    attr_reader :remaining_letters
    attr_reader :word
    
    def initialize(answer = nil)
      if answer 
        @word = answer
      else
        @word = select_answer
      end

      @letterspaces = @word.split("").map!{ |letter| Letterspace.new(letter) }
      @remaining_letters = amend_remaining_letters(@letterspaces)
    end

    def select_answer
      @@dictionary[rand(@@dictionary.length)]
    end

    def amend_remaining_letters(letterspaces)
      letterspaces.filter{ |letterspace|
        letterspace.letter != letterspace.view
      }.map{ |letterspace| letterspace.letter }
    end

    def correct_guesses
      @word.length - amend_remaining_letters(@letterspaces).length
    end

    def current_board
      current_board = ""
      @letterspaces.each do |letterspace|
        current_board = "#{current_board} #{letterspace.view}"
      end
      current_board
    end

    def process_guess(guess)
      is_correct = false
      @letterspaces.each do |letterspace|
        is_correct = true if letterspace.check_guess(guess)
      end
      @remaining_letters = amend_remaining_letters(@letterspaces)
      
      is_correct
    end

    class Letterspace
      attr_reader :view
      attr_reader :letter

      def initialize(letter)
        @view = "_"
        @letter = letter
      end

      def check_guess(guess)
        if guess == @letter
          show()
          true
        end
        false
      end

      def show
        @view = @letter
      end
    end
  end
end

game = Game.new
game.play_round