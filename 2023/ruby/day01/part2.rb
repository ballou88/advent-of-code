require "rspec/autorun"

def parse_line string
  nums = {"one" => "1",
          "two" => "2",
          "three" => "3",
          "four" => "4",
          "five" => "5",
          "six" => "6",
          "seven" => "7",
          "eight" => "8",
          "nine" => "9",
          "1" => "1",
          "2" => "2",
          "3" => "3",
          "4" => "4",
          "5" => "5",
          "6" => "6",
          "7" => "7",
          "8" => "8",
          "9" => "9"}
  last_num = string.reverse.match(/(#{nums.keys.map(&:reverse).join('|')})/, 0)
  return (nums[first_num[0]] + nums[last_num[0].reverse]).to_i
end

def calculate input
  input.lines.sum{ |line| parse_line(line)}
end

# describe "calculate" do
#   it "returns the first and last number for a line" do
#     string = "two1nine"
#     expect(parse_line(string)).to eq 29
#   end
#   it "returns a two digit number even if only a single number is in string" do
#     string = "eightwothree"
#     expect(parse_line(string)).to eq 83
#   end
# end
#
# describe "calulate" do
#   it "returns the sum of all parsed lines" do
#     multiline_string = "two1nine
# eightwothree
# abcone2threexyz
# xtwone3four
# 4nineeightseven2
# zoneight234
# 7pqrstsixteen"
#     expect(calculate(multiline_string)).to eq 281
#   end
# end


input = File.read('input.txt')
puts calculate input

