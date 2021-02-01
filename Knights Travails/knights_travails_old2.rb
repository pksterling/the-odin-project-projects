class Board
  def initialize
    @board_array = []
    x = 0
    while x < 8
      @board_array << []
      y = 0
      while y < 8
        @board_array[x] << Square.new([x, y])
        y += 1
      end
      x += 1
    end
  end

  def square(coordinates)
    x = coordinates[0]
    y = coordinates[1]
    if x.between?(0, 7) and y.between?(0, 7)
      return @board_array[x][y] unless @board_array[x][y].visited
    end
  end
end

class Square
  attr_reader :coordinates, :visited

  def initialize (coordinates)
    @coordinates = coordinates
    @visited = false
  end
end

class Knight
  def initialize(coordinates = [0, 0])
    @root_coordinates = coordinates
    @coordinates = coordinates
    @board = Board.new
  end

  def knights_moves(target, coordinates = @coordinates, path = [])
    path << coordinates
    return path if target == coordinates

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
      @board.square(coordinates)
    end
  end
end

knight = Knight.new([4, 4])
p knight.knights_moves([5, 5])