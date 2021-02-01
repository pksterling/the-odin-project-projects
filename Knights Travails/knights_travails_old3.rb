class Board
  def initialize
    p "Initializing board..."

    @board_array = []
    x = 0
    while x < 8
      p "Adding row ##{x}..."

      @board_array << []
      y = 0
      while y < 8
        @board_array[x] << Square.new([x, y])
        y += 1

      end
      p "Row #{x} complete."
      x += 1
    end

    @board_array.each do |row|
      row.each do |square|
        square.objectify_possible_moves(@board_array)
      end
    end

    p "Board initialized."
  end

  def return_square(coordinates)
    p "Returning #{coordinates}"

    x = coordinates[0]
    y = coordinates[1]

    if x.between?(0, 7) and y.between?(0, 7)
      return @board_array[x][y]
    end
  end
end

class Square
  attr_accessor :visited
  attr_reader :coordinates, :possible_moves

  def initialize (coordinates)
    p "Initializing square #{coordinates}..."

    @coordinates = coordinates
    @visited = false
    @possible_moves = check_moves(coordinates)

    p "Square initialized."
  end

  def self.check_square(coordinates)
    x = coordinates[0]
    y = coordinates[1]

    if x.between?(0, 7) and y.between?(0, 7)
      coordinates
    end
  end

  def check_moves(coordinates)
    p "Checking potential move coordinates for square #{coordinates}..."

    x = coordinates[0]
    y = coordinates[1]
    options = [
      [x - 2, y - 1],
      [x - 2, y + 1],
      [x - 1, y - 2],
      [x - 1, y + 2],
      [x + 1, y - 2],
      [x + 1, y + 2],
      [x + 2, y - 1],
      [x + 2, y + 1]
    ]

    array = options.select do |coordinates|
      Square.check_square(coordinates)
    end
  end

  def objectify_possible_moves(board_array)
    p "Translating possible moves from coordinates to objects for square #{@coordinates}..."

    @possible_moves.map! do |move|
      if move.is_a?(Array)
        x = move[0]
        y = move[1]
        board_array[x][y]
      end
    end

    p "Possible moves translated to objects."
  end
end

class Knight
  def initialize(coordinates = [0, 0])
    p "Initializing knight at square #{coordinates}..."

    @board = Board.new
    @root = @board.return_square(coordinates)

    p "Knight initialized."
  end

  def find_square(target, queue = [@root], path = [])
    p "Finding square #{target}..." if queue == [@root]
    puts "Path so far: #{path}"
    puts queue

    paths = []

    queue.each do |square|
      puts "Processing #{square}..."

      puts "Adding square to path..."
      path << square
      puts "Added square to path."

      return path if square == target

      p "Not matched. Marking square as visited..."
      square.visited = true
      p "Square marked as visited."

      next_up = []
      p "Next up: #{next_up}"
      
      p "Adding possible moves to next-up queue..."
      puts square.possible_moves

      # square.possible_moves.each do |move|
      #   p "Next up: #{next_up}"
      #   p "Move: #{move}"
      #   next_up << move
      #   puts "Added #{move.coordinates} to the queue."
      #   puts "Next up: #{next_up}" 
      # end

      next_up = square.possible_moves.map do |move|
        move
      end

      p next_up

      p "Finished running through current queue. Adding path to paths...."
      p "Target: #{target}"
      puts "Next up: #{next_up}"
      p "Path: #{path}"
      paths << find_square(target, next_up, path)
      p "Added path to paths."
    end

    paths.max { |a, b| a.length <=> b.length }
  end
end

knight = Knight.new([0, 0])
p "Result: #{knight.find_square([1,1])}"