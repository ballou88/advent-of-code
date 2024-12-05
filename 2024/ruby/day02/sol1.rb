reports = []

def monotonic?(report)
  report.sort === report || report.sort.reverse === report
end

def safe_levels?(report)
  report.each_cons(2) do |a, b|
    return false if (b - a) == 0 or (a - b).abs > 3
  end
end

File.foreach('input.txt') do |line|
  reports << line.chomp.split.map(&:to_i)
end

safe = 0
reports.each do |report|
  safe += 1 if monotonic?(report) && safe_levels?(report)
end

puts safe
