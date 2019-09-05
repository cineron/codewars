#!/usr/bin/env ruby
require 'pp'

NORTH = 0
EAST = 1
SOUTH = 2
WEST = 3
WHITE = 1 
BLACK = 0

def ant(grid, column, row, n, dir=NORTH)
  #puts "Starting grid"
  #puts grid.inspect
  #puts "column #{column} row #{row} dir #{dir}"
  #puts " "
  while (n > 0) do
    this_color = grid[row][column]

    if this_color == BLACK
      dir = turn_left(dir)
      grid[row][column] = inverse_color(this_color)
      grid, column, row = move(grid, column, row, dir)
    elsif this_color == WHITE
      dir = turn_right(dir)
      grid[row][column] = inverse_color(this_color)
      grid, column, row = move(grid, column, row, dir)
    end

    #puts "Grid after moving"
    #puts grid.inspect
    #puts "column #{column} row #{row} dir #{dir}"
    #puts " "
    n -= 1
  end
  grid
end

def move(grid, column, row, dir)
  # TODO: Expand grid if needed
  if dir == NORTH
    if (row - 1 < 0)
      grid = expand(grid, dir)
      row += 1
    end
    return grid, column, row - 1
  elsif dir == SOUTH
    if (row + 1 >= grid.length)
      grid = expand(grid, dir)
    end
    return grid, column, row + 1
  elsif dir == EAST
    if (column + 1 >= grid[0].length)
      grid = expand(grid, dir)
    end
    return grid, column + 1, row
  elsif dir == WEST
    if (column - 1 < 0)
      grid = expand(grid, dir)
      column += 1
    end
    return grid, column - 1, row
  end
end

def turn_right(dir)
  # Possibly dir + 1 % 4
  if dir == NORTH
    return EAST
  elsif dir == SOUTH
    return WEST
  elsif dir == EAST
    return SOUTH
  elsif dir == WEST
    return NORTH
  end
end

def turn_left(dir)
  # Possibly dir - 1 % 4
  if dir == NORTH
    return WEST
  elsif dir == SOUTH
    return EAST
  elsif dir == EAST
    return NORTH
  elsif dir == WEST
    return SOUTH
  end
end

def inverse_color(color)
  color == BLACK ? WHITE : BLACK
end

def expand(grid, dir)
  puts "Expanding"
  if dir == NORTH
    return expand_north(grid)
  elsif dir == SOUTH
    return expand_south(grid)
  elsif dir == EAST
    return expand_east(grid)
  elsif dir == WEST
    return expand_west(grid)
  end
  raise "Expand: Given invalid direction"
end

def expand_north(grid)
  cols = (grid[0].length) -1
  new_row = Array.new(cols + 1, 0)
  grid.prepend(new_row)
  grid
end

def expand_south(grid)
  cols = (grid[0].length) -1
  new_row = Array.new(cols + 1, 0)
  grid.push(new_row) 
  grid
end

def expand_east(grid)
  rows = grid.length - 1
  cols = (grid[0].length) -1

  0.upto(rows) do |y|
    grid[y].push(0)
  end

  grid
end

def expand_west(grid)
  rows = grid.length - 1
  cols = (grid[0].length) -1

  0.upto(rows) do |y|
    grid[y].prepend(0)
  end

  grid
end


if false
  puts "Testing A"
  a = ant([[1]], 0, 0, 1, 0)
  a_expected =  [[0, 0]]
  puts "Testing B"
  b = ant([[0]], 0, 0, 1)
  b_expected =  [[0, 1]]
end

puts "Testing C"
c = ant([[1]], 0, 0, 3, 0) 
c_expected = [[0, 1], [0, 1]]

if false
  puts "A"
  puts a.inspect
  puts a_expected.inspect
  puts "B"
  puts b.inspect
  puts b_expected.inspect
end

puts "C"
puts c.inspect
puts c_expected.inspect
