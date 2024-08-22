require 'rspec/autorun'

def parse_line string
  nums = string.gsub(/[^0-9]/, '')
  return (nums[0] + nums[-1]).to_i
end

def calculate input
  input.lines.sum{ |line| parse_line(line) }
end

describe "calculate" do
  it "returns the first and last number for a line" do
    string = "1adsf3dd"
    expect(parse_line(string)).to eq 13
  end
  it "returns a two digit number even if only a single number is in string" do
    string = "asd7adsf"
    expect(parse_line(string)).to eq 77 
  end
end

describe "calulate" do
  it "returns the sum of all parsed lines" do
    multiline_string = "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"
    expect(calculate(multiline_string)).to eq 142
  end
end


