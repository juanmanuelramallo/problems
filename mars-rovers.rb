# MARS ROVERS
#
# A squad of robotic rovers are to be landed by NASA on a plateau on Mars.
#
# This plateau, which is curiously rectangular, must be navigated by the rovers so that their on board cameras can get a complete view of the surrounding terrain to send back to Earth.
#
# A rover's position is represented by a combination of an x and y co-ordinates and a letter representing one of the four cardinal compass points. The plateau is divided up into a grid to simplify navigation. An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.
#
# In order to control a rover, NASA sends a simple string of letters. The possible letters are 'L', 'R' and 'M'. 'L' and 'R' makes the rover spin 90 degrees left or right respectively, without moving from its current spot.
#
# 'M' means move forward one grid point, and maintain the same heading.
#
# Assume that the square directly North from (x, y) is (x, y+1).
#
# Input:
# The first line of input is the upper-right coordinates of the plateau, the lower-left coordinates are assumed to be 0,0.
#
# The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover's position, and the second line is a series of instructions telling the rover how to explore the plateau.
#
# The position is made up of two integers and a letter separated by spaces, corresponding to the x and y co-ordinates and the rover's orientation.
#
# Each rover will be finished sequentially, which means that the second rover won't start to move until the first one has finished moving.
#
# Output:
# The output for each rover should be its final co-ordinates and heading.
#
# Test Input:
#
# 5 5
# 1 2 N
# LMLMLMLMM
# 3 3 E
# MMRMMRMRRM
#
# Expected Output:
#
# 1 3 N
# 5 1 E

Position = Struct.new(:x, :y)

class Grid
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  def contains?(position)
    position.x < width && position.y < height
  end
end

Direction = Struct.new(:x, :y, :index)
Directions = [
  ['N', Direction.new(0, 1, 0)],
  ['E', Direction.new(1, 0, 1)],
  ['S', Direction.new(0, -1, 2)],
  ['W', Direction.new(-1, 0, 3)]
]
LEFT = -1
RIGHT = 1

class Rover
  attr_reader :position, :direction, :grid

  def initialize(position, direction, grid)
    @position = position
    @direction = direction
    @grid = grid
    @stop = false
  end

  def execute(command)
    return if stop?

    if command.steps > 0
      move(command.steps)
    else
      turn(command.turns)
    end
  end

  def status
    [
      ("Stopped at" if stop?),
      "#{position.x} #{position.y} #{Directions[direction.index][0]}"
    ].compact.join(' ')
  end

  def move(steps = 1)
    new_position = Position.new(position.x + (direction.x * steps), position.y + (direction.y * steps))

    if grid.contains?(new_position)
      @position = new_position
    else
      @stop = true
    end
  end

  def turn(turns)
    turns.each do |turning|
      value = turning == 'L' ? LEFT : RIGHT
      @direction = Directions[(direction.index + value) % 4][1]
    end
  end

  private

  def stop?
    @stop
  end
end

class Command
  attr_reader :command

  def self.from_array(array)
    array.map { |a| new(a) }
  end

  def initialize(command)
    @command = command
  end

  def steps
    command.count('M')
  end

  def turns
    command.chars
  end
end

class RemoteControl
  attr_reader :commands, :rover

  def initialize(command, rover)
    @commands = Command.from_array(command.scan(/([LR]+|M+)/).flatten)
    @rover = rover
  end

  def execute
    commands.each do |command|
      rover.execute(command)
    end

    puts rover.status
  end
end

class InputParser
  attr_reader :grid, :remote_controls, :rovers

  def initialize(input)
    lines = input.strip.split("\n")
    max_x, max_y = lines.shift.split(' ')
    @grid = Grid.new(max_x.to_i + 1, max_y.to_i + 1)
    @rovers = []
    @remote_controls = []

    (lines.size / 2).times do
      x, y, direction = lines.shift.split(' ')
      command = lines.shift
      direction = Directions.to_h[direction]
      position = Position.new(x.to_i, y.to_i)
      rover = Rover.new(position, direction, @grid)
      @remote_controls << RemoteControl.new(command, rover)
      @rovers << rover
    end
  end
end


# Tests

input = "
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
0 0 N
MMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMRMMMMMRMMMMMRMMMMMRMMMMMRRLRLMMMMMR
"
parser = InputParser.new(input)
parser.remote_controls.each(&:execute)

puts "Rover 1"
puts (parser.rovers[0].position.x == 1 &&
        parser.rovers[0].position.y == 3 &&
        parser.rovers[0].direction.index == 0)

puts "Rover 2"
puts (parser.rovers[1].position.x == 5 &&
        parser.rovers[1].position.y == 1 &&
        parser.rovers[1].direction.index == 1)

puts "Rover 1"
puts (parser.rovers[2].position.x == 5 &&
        parser.rovers[2].position.y == 5 &&
        parser.rovers[2].direction.index == 2)

