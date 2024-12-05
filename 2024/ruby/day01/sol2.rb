list1 = Set.new
list2 = Hash.new(0)
File.foreach('input1.txt') do |line|
  a, b = line.chomp.split
  list1.add a.to_i
  list2[b.to_i] += 1
end
simularity_score = 0
list1.each do |a|
  simularity_score += a * list2[a]
end

puts simularity_score
