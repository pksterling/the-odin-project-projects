class Human
  attr_reader :role

  def initialize
    @role = select_role
  end

  # Allows player to type in four coloured pegs
  def input_code(peg_options)
    code = []
    puts "You're peg options are #{peg_options.join(", ")}"

    4.times do |peg_number|
      selection = ""

      # Only allow selections from the peg_options
      until peg_options.any? { |peg| peg == selection }
        puts "Enter colour for peg ##{peg_number + 1}"
        selection = gets.chomp.downcase
      end

      code.push(selection)
    end
    
    puts "You input #{code}"
    code
  end

  private

  def select_role
    puts "Would you like to be 'codemaker' or 'codebreaker'? Type your answer:"
    role = ""
    until role == 'codemaker' || role == 'codebreaker'
      role = gets.chomp
    end
    puts "You have chosen #{role}"
    role
  end
end

class Computer
  attr_reader :role
  
  def initialize(human)
    @role = human.role == "codemaker" ? "codebreaker" : "codemaker"
  end
      
  # Randomly selects four coloured pegs from the available options
  def input_code(peg_options)
    code = []
    
    4.times { code.push(peg_options.sample) }
      
    puts "Computer code generated"

    code
  end
end

class Game
  attr_reader :peg_options

  def initialize
    @peg_options = ["black", "blue", "green", "red", "white", "yellow"]
    puts "Welcome to Mastermind"

    # If human's role is codebreaker, computer randomly generates code
    # If human's role is codemaker, computer follows solving algorithm
    arrange_roles == "codemaker" ? play_smart_ai : play_game
  end

  def arrange_roles
    human = Human.new
    computer = Computer.new(human)

    if human.role == "codemaker"
      @codemaker = human
      @codebreaker = computer
    else
      @codemaker = computer
      @codebreaker = human
    end

    return human.role
  end

  def check_code(code, guess)
    exact_matches = 0
    color_matches = 0
    checked_guess = guess.clone
  
    # Checks for exact colour + positional matches
    checked_code = code.map.with_index do |peg, index|
      if peg == checked_guess[index]
        peg = "guessed"
        checked_guess[index] = "correct"
        exact_matches += 1
      end
      peg
    end
  
    # Checks remaining pegs for colour-only matches
    checked_code.each do |peg|
      if checked_guess.index(peg)
        checked_guess[checked_guess.index(peg)] = "matched"
        color_matches += 1
      end
    end
  
    matches = {exact_matches: exact_matches, color_matches: color_matches}
  end

  # Play with computer randomly generating codes
  def play_game
    exact_matches = 0
    goes = 0
    code = @codemaker.input_code(peg_options)

    until exact_matches == 4 || goes >= 12
      goes += 1
      guess = @codebreaker.input_code(peg_options)
      matches = check_code(code, guess)
      puts "You have #{matches[:exact_matches]} exact matches and #{matches[:color_matches]} colour-only matches."
      exact_matches = matches[:exact_matches]
    end

    check_result(exact_matches, goes)
  end

  def play_smart_ai
    @exact_matches = 0
    goes = 0
    code = @codemaker.input_code(peg_options)

    # Logs every single possible code
    options = @peg_options.repeated_permutation(4).to_a
    guess = []
    # Start by guessing ["black", "black", "blue", "blue"]
    guess = options[7] if goes == 0

    # Computer uses algorithm to keep guessing until correct
    def guessing_algorithm(options, code, guess, goes)
      goes += 1
      return goes if goes > 12

      puts "Go ##{goes}\nComputer guessed #{guess}"
      matches = check_code(code, guess)
      puts "Computer has #{matches[:exact_matches]} exact matches and "\
      "#{matches[:color_matches]} colour-only matches."
      @exact_matches = matches[:exact_matches]
      return goes if @exact_matches == 4

      # Remove all options that are not possible
      options.select! do |option|
        check_code(code, guess) == check_code(guess, option)
      end

      # Remove the current guess from the remaining options
      options.delete(guess)
      guess = options[0]
      puts "Computer has narrowed it down to #{options.length} possibilities."

      puts "Press enter to continue..."
      gets
      # Guess again
      guessing_algorithm(options, code, guess, goes)
    end

    goes = guessing_algorithm(options, code, guess, goes)
    check_result(@exact_matches, goes)
    
  end

  def check_result(matches, goes)
    if matches == 4
      puts "Congratulations codebreaker, "\
      "you decrypted the code in #{goes} goes!"
    else
      puts "Congratulations codemaker, you outsmarted your opponent this time"
    end
  end

end

game = Game.new