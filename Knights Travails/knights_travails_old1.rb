class Board
  def initialize
    puts "Initializing game board..."
    @board_array = []

    x = 0
    while x < 8
      puts "Creating row ##{x}..."
      @board_array << []

      y = 0
      while y < 8
        @board_array[x] << Square.new(x, y)

        y += 1
      end

      puts "Row ##{x} complete."
      x += 1
    end

    puts "Game board initialized."
  end

  def return_square (x, y)
    return nil if x > 7 || x < 0 || y > 7 || y < 0
    @board_array[x][y]
  end

  def print_board_coordinates
    puts "Compiling printout..."
    result = []
    
    x = 0
    while x < 8
      result << []

      y = 0
      while y < 8
        result[x] << @board_array[x][y].coordinates

        y += 1
      end

      x += 1
    end

    puts "Game board:"
    result.each { |row| puts "#{row}\n"}
  end
end

class Knight 
  def initialize(x, y)
    puts "Initializing knight piece..."
    @x = x
    @y = y
    @coordinates = [x, y]

    @visited_coordinates = [@coordinates]
    puts "Knight piece initialized."
  end

  def build_tree (x, y)
    puts "Building knight piece's move tree..."
    root = Node.new(x, y)
    @visited_coordinates << root.coordinates
    puts "Knight piece's move tree built."
  end
end

class Node
  def initialize(square)
    return nil if x > 7 || x < 0 || y > 7 || y < 0
    puts "Initializing node for square #{[x, y]}"

    @coordinates = [x, y]
    @root = board.return_square(x, y)
    @paths = [
      @board_array[x + 1][y - 2],
      @board_array[x + 2][y - 1],
      @board_array[x + 2][y + 1],
      @board_array[x + 1][y + 2],
      @board_array[x - 1][y + 2],
      @board_array[x - 2][y + 1],
      @board_array[x - 2][y - 1],
      @board_array[x - 1][y - 2],
    ]

    puts "Node for square #{[x, y]} initialized."
  end
end

class Square
  attr_reader :x, :y, :coordinates

  def initialize(x, y)
    puts "Initializing square #{[x, y]}..."
      @x = x
      @y = y
      @coordinates = [@x, @y]
      puts "Square #{@coordinates} initialized."
  end
end

board = Board.new
knight = Knight.new