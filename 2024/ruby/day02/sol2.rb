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
  if monotonic?(report) && safe_levels?(report)
    safe += 1
  else
    reports.each.with_index do |r, i|
      sub_report = if i < report.length
                     report[0...i] + report[(i + 1)..]
                   else
                     report[...-1]
                   end
      if monotonic?(sub_report) && safe_levels?(sub_report)
        safe += 1
        break
      end
    end
  end
end

puts safe
