file = File.read('input.txt')
ordering, printing = file.split("\n\n")

order = Hash.new { |h, k| h[k] = [] }

ordering.each_line do |line|
  num, after = line.strip.split('|')
  order[num.to_i] << after.to_i
end

def valid?(list, order)
  list.each_with_index do |num, i|
    list[(i + 1)..].each do |after|
      return false if order[after].include?(num)
    end
  end
  true
end
manuals = printing.split("\n").map { |line| line.split(',').map(&:to_i) }
pp manuals
out = 0
manuals.each do |manual|
  out += manual[manual.size / 2.floor] if valid?(manual, order)
end

puts out
