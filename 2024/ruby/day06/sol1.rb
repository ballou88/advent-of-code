DIRECTIONS = ['^', '>', 'v', '<']
board = []
D = [[-1, 0], [0, 1], [1, 0], [0, -1]]
File.open('input.txt').each do |line|
  board << line.chomp.split('')
end

def find_start(board)
  board.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      return [i, j, cell] if ['^', '>', '<', 'v'].include?(cell)
    end
  end
end

start_r, start_c, direction = find_start(board)

max_r = board.length - 1
max_c = board[0].length - 1
start_r, start_c, direction = find_start(board)

direction = 0
r = start_r
c = start_c

seen = Set.new

while true
  seen << [r, c]
  dr, dc = D[direction]
  next_r = r + dr
  next_c = c + dc
  unless next_r.between?(0, max_r) && next_c.between?(0, max_c)
    path_length = seen.size
    break
  end
  if board[next_r][next_c] == '#'
    direction = (direction + 1) % 4
  else
    r = next_r
    c = next_c
  end
end
p path_length
