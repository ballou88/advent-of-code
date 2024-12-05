file = File.read('input.txt')
total = 0
file.scan(/mul\((\d+{1,3}),(\d+{1,3})\)/) do |a, b|
  total += a.to_i * b.to_i
end

puts total
