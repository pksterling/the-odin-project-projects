class Board
  # Create an 8x8 2d array of 'squares', each containing an empty 'path' array
  def initialize
    @board_array = []
    x = 0
    while x < 8
      @board_array << []
      y = 0
      while y < 8
        @board_array[x] << []
        y += 1
      end

      x += 1
    end
  end

  # Return the path contained in a particular square
  # If the square does not exist on the board, return nil
  def square_path(coordinates)
    x = coordinates[0]
    y = coordinates[1]
    if coordinates[0].between?(0, 7) and coordinates[1].between?(0, 7)
      @board_array[x][y]
    end
  end

  # Add a given path to a particular square
  def add_path(coordinates, path)
    x = coordinates[0]
    y = coordinates[1]
    @board_array[x][y] = path
  end
end

class Knight
  # Create a 'knight' at the given coordinates
  def initialize(coordinates)
    @coordinates = coordinates
    @board = Board.new
    @board.add_path(coordinates, [coordinates])
  end

  def find_square(target, queue = [@coordinates])
    current_square = queue.delete_at(0)
    path = @board.square_path(current_square)

    return path if current_square == target

    x = current_square[0]
    y = current_square[1]
    # Create an array 'options' containing all possible knight moves
    options = [[x - 2, y - 1], [x - 2, y + 1], [x - 1, y - 2], [x - 1, y + 2], [x + 1, y - 2], [x + 1, y + 2], [x + 2, y - 1], [x + 2, y + 1]]

    # For each possible move, check the landing square exists and is unvisited
    # If so, add the knight's path to the square and add it to the queue
    options.each do |coordinates|
      if @board.square_path(coordinates) == []
        @board.add_path(coordinates, path.clone << coordinates)
        queue << coordinates
      end
    end

    # Run the function again, checking the next in the queue against the target
    find_square(target, queue)
  end
end

# Function compiling the above into a neat function
def knight_moves(starting_coordinates, target_coordinates)
  path = Knight.new(starting_coordinates).find_square(target_coordinates)
  p "You made it in #{path.length - 1} moves! Here's your path:"
  path.each { |square| p square}
end

knight_moves([0,0], [6,6])