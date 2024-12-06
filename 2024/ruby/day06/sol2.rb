DIRECTIONS = ['^', '>', 'v', '<']
D = [[-1, 0], [0, 1], [1, 0], [0, -1]]
board = []
File.open('input.txt').each do |line|
  board << line.chomp.split('')
end

board2 = Marshal.load(Marshal.dump(board))

def find_start(board)
  board.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      return [i, j, cell] if ['^', '>', '<', 'v'].include?(cell)
    end
  end
end

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

obj_count = 0
seen.each do |obj_r, obj_c|
  direction = 0
  r = start_r
  c = start_c
  seen2 = Set.new
  while true
    if seen2.include?([r, c, direction])
      obj_count += 1
      break
    end
    seen2 << [r, c, direction]
    dr, dc = D[direction]
    next_r = r + dr
    next_c = c + dc
    break unless next_r.between?(0, max_r) && next_c.between?(0, max_c)

    if board[next_r][next_c] == '#' || (next_r == obj_r && next_c == obj_c)
      direction = (direction + 1) % 4
    else
      r = next_r
      c = next_c
    end
  end
end
p obj_count
