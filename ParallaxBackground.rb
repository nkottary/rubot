require_relative 'helpers'
#draw a parallax background i.e move the background image as player moves.
class ParallaxBackground

  def initialize(window, filename, map_width, map_height)
    @image = Image.new(window, filename, true)

    #pixel ratio of image to window.
    @w_ratio = Float(@image.width) / map_width
    @h_ratio = Float(@image.height) / map_height

    @x, @y = 0, 0
  end

  def draw
    @image.draw(@x, @y, ZOrder::Background) 
  end

  def update(camera_x, camera_y)
    @x = -camera_x * @w_ratio
    @y = -camera_y * @h_ratio
  end
end