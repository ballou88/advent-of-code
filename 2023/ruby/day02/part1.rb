require 'rspec/autorun'

input = <<-INPUT
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
INPUT

lines = input.split("\n")

def part1 lines
  lines.sum do |line|
    data = parse line
    data[:rounds].all?{|round| valid? round} ? data[:game] : 0
  end
end

def valid? round
  round[:blue].to_i <=14 and round[:red].to_i <=12 and round[:green].to_i <=13
end

def parse line
  game, rounds = line.split(':')
  rounds = rounds.split(';').map do |round|
    round.split(',').map do |color|
      color = color.split(' ')
      {color[1].to_sym => color[0].to_i}
    end.reduce(:merge)
  end
  {game: game.split(' ')[1].to_i, rounds: rounds}
end

describe 'part1' do
  it 'should return the correct result' do
    line = 'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'
    expect(parse(line)).to eq({game: 1, rounds: [{blue: 3, red: 4}, {red: 1, green: 2, blue: 6}, {green: 2}]})
  end
end

file_input = File.read('input.txt').lines
 p part1(file_input)
