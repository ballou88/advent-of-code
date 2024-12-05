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
# loop through board
# for each x I encounter
# loop through the 4 directions looking for a mas(dir)
# from mas call as(dir)
# from as ca a(dir) if any
class Solution
  def initialize(board)
    @board = board
    @found = Array.new(board.length) { Array.new(board[0].length, '.') }
  end

  def crawl_board
    count = 0
    for y in 0...@board.length
      for x in 0...@board[0].length
        next unless @board[y][x] == 'A'

        # check if up/down and left/right and/or diags
        next unless diags?(x, y) # || hor_vert?(x, y)

        if diags?(x, y)
          found_at(x, y, UP_LEFT)
          found_at(x, y, UP_RIGHT)
          found_at(x, y, DOWN_LEFT)
          found_at(x, y, DOWN_RIGHT)
        end
        # if hor_vert?(x, y)
        #   found_at(x, y, UP)
        #   found_at(x, y, DOWN)
        #   found_at(x, y, RIGHT)
        #   found_at(x, y, LEFT)
        # end
        count += 1
        @found[y][x] = 'A'
      end
    end
    File.open('out.txt', 'w') do |f|
      @found.each do |line|
        f.write(line.join('') + "\n")
      end
    end
    puts count
  end

  def diags?(x, y)
    valid = Set.new(%w[M S])
    [value_at(x, y, UP_LEFT), value_at(x, y, DOWN_RIGHT)].to_set == valid &&
      [value_at(x, y, UP_RIGHT), value_at(x, y, DOWN_LEFT)].to_set == valid
  end

  def hor_vert?(x, y)
    valid = Set.new(%w[M S])
    [value_at(x, y, UP), value_at(x, y, DOWN)].to_set == valid &&
      [value_at(x, y, LEFT), value_at(x, y, RIGHT)].to_set == valid
  end

  def found_at(x, y, direction)
    @found[y + direction[1]][x + direction[0]] = @board[y + direction[1]][x + direction[0]]
  end

  def value_at(x, y, direction)
    is_in_bounds(x, y, direction) && @board[y + direction[1]][x + direction[0]]
  end

  def is_in_bounds(x, y, direction)
    y + direction[1] >= 0 &&
      y + direction[1] < @board.length &&
      x + direction[0] >= 0 &&
      x + direction[0] < @board[0].length
  end
end

Solution.new(board).crawl_board # is_x?(0, 5, RIGHT)
