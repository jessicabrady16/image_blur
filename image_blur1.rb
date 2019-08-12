class Image
  def initialize(grid)
  @grid = grid
  end

  def output_image
    @grid.each do |row|
     puts row.join ""
    end
  end
end


image = Image.new([
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 1],
  [0, 0, 0, 0]
])

image.output_image


