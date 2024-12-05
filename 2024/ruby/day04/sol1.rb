board = []
File.foreach('input.txt') do |line|
  board << line.chomp.split('')
end
UP = [-1, 0]
DOWN = [1, 0]
LEFT = [0, -1]
RIGHT = [0, 1]
UP_LEFT = [-1, -1]
UP_RIGHT = [-1, 1]
DOWN_LEFT = [1, -1]
DOWN_RIGHT = [1, 1]
DIRECTIONS = [UP, DOWN, LEFT, RIGHT, UP_LEFT, UP_RIGHT, DOWN_LEFT, DOWN_RIGHT]
# loop through board
# for each x I encounter
# loop through the 4 directions looking for a mas(dir)
# from mas call as(dir)
# from as ca a(dir) if any
class Solution
  def initialize(board)
    @board = board
    @found = Array.new(10) { Array.new(10, '.') }
    @m = 0
    @a = 0
    @s = 0
  end

  def crawl_board
    count = 0
    for y in 0...@board.length
      for x in 0...@board[0].length
        if @board[y][x] == 'X'
          DIRECTIONS.each do |direction|
            next unless is_m?(x, y, direction)

            count += 1
            # @found[y][x] = 'X'
          end
        else
        end
      end
    end
    puts count
  end

  def is_x?(x, y, direction)
    puts x
    puts y
    puts @board[y][x]
    if @board[y][x] == 'X' &&
       is_m?(x + direction[0], y + direction[1], direction)
      @found[y][x] = 'X'
      pp @found
      true
    end
  end

  def is_m?(x, y, direction)
    @m += 1
    if is_in_bounds(x, y, direction) &&
       @board[y + direction[1]][x + direction[0]] == 'M' &&
       is_a?(x + direction[0], y + direction[1], direction)
      # @found[y + direction[1]][x + direction[0]] = 'M'
      true
    end
  end

  def is_a?(x, y, direction)
    @a += 1
    if is_in_bounds(x, y,
                    direction) && @board[y + direction[1]][x + direction[0]] == 'A' and is_s?(x + direction[0],
                                                                                              y + direction[1], direction)
      # @found[y + direction[1]][x + direction[0]] = 'A'
      true
    end
  end

  def is_s?(x, y, direction)
    @s += 1
    if is_in_bounds(x, y, direction) &&
       @board[y + direction[1]][x + direction[0]] == 'S'
      # @found[y + direction[1]][x + direction[0]] = 'S'
      true
    end
  end

  def is_in_bounds(x, y, direction)
    y + direction[1] >= 0 &&
      y + direction[1] < @board.length &&
      x + direction[0] >= 0 &&
      x + direction[0] < @board[0].length
  end
end

Solution.new(board).crawl_board # is_x?(0, 5, RIGHT)
