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
    game = parse line
    power game
  end
end

def power game
  blue_min = 0
  green_min = 0
  red_min = 0
  game[:rounds].each do |round|
    blue_min = [blue_min, (round[:blue] || 0)].max
    red_min =  [red_min, (round[:red] || 0)].max
    green_min = [green_min, (round[:green] || 0)].max
  end
  return blue_min * red_min * green_min
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
    game = {game: 1, rounds: [{blue: 3, red: 4}, {red: 1, green: 2, blue: 6}, {green: 2}]}
    expect(power(game)).to eq(48)
  end
end
file_input = File.read('input.txt').lines
p part1(file_input)
