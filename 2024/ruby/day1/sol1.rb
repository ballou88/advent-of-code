list1 = []
list2 = []
File.foreach('input1.txt') do |line|
  a, b = line.chomp.split
  list1 << a.to_i
  list2 << b.to_i
end

list1.sort!
list2.sort!

distance = 0
list1.zip(list2).each do |a, b|
  distance += (b - a).abs
end

puts distance
