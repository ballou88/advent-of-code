file = File.read('input.txt')
# file = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
total = 0
s = file.gsub(/don't\(\).+?do\(\)/m, '').gsub(/don't\(\).*?$/m, '')
s.scan(/mul\((\d+{1,3}),(\d+{1,3})\)/) do |a, b|
  total += a.to_i * b.to_i
end

puts total
