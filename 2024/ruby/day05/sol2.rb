file = File.read('test.txt')
ordering, printing = file.split("\n\n")

before = Hash.new { |h, k| h[k] = Set.new }
after = Hash.new { |h, k| h[k] = Set.new }

# Create 2 hashes one mapping pages to pages that have to be before them
# and one mapping pages to pages that have to be after them
ordering.each_line do |line|
  num, page = line.strip.split('|')
  before[num.to_i] << page.to_i
  after[page.to_i] << num.to_i
end

# Determine if each manual is valid
def valid?(list, order)
  list.each_with_index do |num, i|
    list[(i + 1)..].each do |after|
      return false if order[after].include?(num)
    end
  end
  true
end

# Parse the manual pages
manuals = printing.split("\n").map { |line| line.split(',').map(&:to_i) }

# For each manual partition those that are valid/not
_, invalid = manuals.partition { |manual| valid?(manual, before) }

out = 0
invalid.each do |manual|
  valid_order = []
  queue = []
  dict = manual.each_with_object({}) do |page, h|
    h[page] = (before[page] & Set.new(manual)).size
  end
  manual.each { |page| queue << page if dict[page] == 0 }
  until queue.empty?
    page = queue.shift
    valid_order << page
    after[page].each do |v|
      next unless dict.include?(v)

      dict[v] -= 1
      queue << v if dict[v] == 0
    end
  end
  out += valid_order[(valid_order.size / 2).floor]
  p "\n\n"
end
puts out
