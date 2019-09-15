#- frozen_string_literal: true\
class Point
  attr_reader :x, :y
  def initialize(x,y)
    raise "x is not an integer: #{x}" unless x.is_a? Integer
    raise "y is not an integer: #{y}" unless y.is_a? Integer
    @x = x
    @y = y
  end
# doing this because I am overridding the compare memory objects to show it how to compare the two points)
  def eql?(other_point)
    @x == other_point.x && @y == other_point.y
  end

  def ==(other_point)
    eql?(other_point)
  end
end

class Image

  attr_reader :grid
  def initialize(grid, manhan_dist)
    @grid = grid
    @manhan_dist = manhan_dist
    @grid_width = @grid[0].length
    @grid_height = @grid.length
  end

 # this is the function that says we are in bounds
  def inbounds?(point)
    return false if point.x < 0
    return false if point.x >= @grid_width
    return false if point.y < 0
    return false if point.y >= @grid_height
    return true
  end

  # in recursion, this is called the base_case, we are basically gathering addressing here of coordinates to push to an array for in the end to change to 1, first thing we are doing is checking if we are in bounds of the grid or there would be no reason to check man_dist, if we are, we will check if the delta  X and delta Y are within the man_dist, we are also checking if we visited the array point and if we didn't we are pushing it to the visited array so we don't just loop over and over the same area-- visited array is here so it makes a new one for each "1".
  def recursive_blur_impl(start, current, things_to_blur,visited_array)
     if visited_array.include?(current)
      return
     else
      visited_array.push(current)
     end
    inbounds?(current)
      unless inbounds?(current)
        return
      end
      dist_between_start_to_current = (start.x - current.x).abs + (start.y - current.y).abs
      if dist_between_start_to_current > @manhan_dist
        return
      end
      things_to_blur.push(current)
      left_cell = Point.new(current.x-1, current.y)
      recursive_blur_impl(start, left_cell, things_to_blur, visited_array)
      right_cell = Point.new(current.x+1, current.y)
      recursive_blur_impl(start, right_cell, things_to_blur, visited_array)
      up_cell = Point.new(current.x, current.y-1)
      recursive_blur_impl(start, up_cell, things_to_blur, visited_array)
      down_cell = Point.new(current.x, current.y+1)
      recursive_blur_impl(start, down_cell, things_to_blur, visited_array)
  end

  #helper methiod..needy computers (kicking off the recursion by blurring out from origin point in all 4 directions left, down, up, right)
  def recursive_blur(start, things_to_blur)
    visited_array = [start]
    left_cell = Point.new(start.x-1, start.y)
    recursive_blur_impl(start, left_cell, things_to_blur, visited_array)
    right_cell = Point.new(start.x+1, start.y)
    recursive_blur_impl(start, right_cell, things_to_blur, visited_array)
    up_cell = Point.new(start.x, start.y-1)
    recursive_blur_impl(start, up_cell, things_to_blur, visited_array)
    down_cell = Point.new(start.x, start.y+1)
    recursive_blur_impl(start, down_cell, things_to_blur, visited_array)
  end

  #need to take all the points and make them a 1.
  def blur
    things_to_blur = []
    # looking for 1s to blur going through each array
    @grid.each_with_index do |or_row, row_index|
      or_row.each_with_index do |cell, cell_index|
        #is this current cell a 1?
        if cell == 1
        #run function on code
          recursive_blur(Point.new(cell_index, row_index), things_to_blur)
        end
      end
    end
    things_to_blur.each do |point|
      @grid[point.y][point.x] = 1
    end
    output_image
  end

  def output_image
    @grid.each do |row|
      puts row.join ''
    end
  end
end

grid =
  [ [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 1],
  ]
Image.new(grid,2).blur
