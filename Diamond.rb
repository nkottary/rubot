require_relative 'helpers'

class Diamond
  attr_reader :x, :y

  def initialize(image, x, y)
    @image = image
    @x, @y = x, y
    @angle = 0
  end

  def update
  	@angle = 25 * Math.sin(milliseconds / 133.7)
  end
  
  def draw
    # Draw, slowly rotating
    @image.draw_rot(@x, @y, ZOrder::Diamond, @angle)
  end
end