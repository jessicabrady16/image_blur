# frozen_string_literal: true

class Image
  attr_reader :grid
  def initialize(grid)
    @grid = grid
   @manhan_dist = n
  end

  def blur
    result = []
    @grid.each_with_index do |or_row, row_index|
      result_row = []
      or_row.each_with_index do |cell, cell_index|
        left_index = cell_index - 1
        right_index = cell_index + 1
        up_index = row_index - 1
        down_index = row_index + 1

        if left_index >= 0 && or_row[left_index] == 1
          result_row.push(1)
        elsif right_index < or_row.length && or_row[right_index] == 1
          result_row.push(1)
        elsif up_index >= 0 && @grid[up_index][cell_index] == 1
          result_row.push(1)
        elsif down_index < @grid.length && @grid[down_index][cell_index] == 1
          result_row.push(1)
        else
          result_row.push(cell)
        end
      end
      result.push(result_row)
    end
    @grid = result
    self
  end

  def output_image
    @grid.each do |row|
      puts row.join ''
    end
  end
end

image = Image.new(
  [ [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 1]
  ]
)


#blur
image.begin
image.output_image
expected =
  [
    [0, 1, 0, 0],
    [1, 1, 1, 1],
    [0, 1, 1, 1],
    [1, 1, 1, 1],
    [1, 1, 0, 0],
    [1, 1, 0, 0]
  ]

puts (expected == image.grid).to_s
