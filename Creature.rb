require_relative 'helpers'

#Super class for player and all bots.
class Creature

  @@vel_x = 2

  attr_reader :x, :y

  def initialize(window, x, y)
    # This always points to the frame that is currently drawn.
    # This is set in update, and used in draw.
    @cur_image = nil    

    @x = x
    @y = y
    @width = 50
    @height = 50

    @vy = 0

    @dir = :right

    @map = window.map
  end

  def draw
    # Flip vertically when facing to the left.
    if @dir == :left then
      offs_x = @width / 2
      factor = -1.0
    else
      offs_x = -@height / 2
      factor = 1.0
    end

    if @cur_image then @cur_image.draw(@x + offs_x, @y - @height + 1, ZOrder::Creature, factor, 1.0) end
  end

  def reverse
    @dir = @dir == :right ? :left : :right
  end

  # Could the object be placed at x + offs_x/y + offs_y without being stuck?
  def would_fit(offs_x, offs_y)
    # Check at the center/top and center/bottom for map collisions
    not @map.solid?(@x + offs_x + (@width / 2), @y + offs_y) and not @map.solid?(@x + offs_x - (@width / 2), @y + offs_y) and
      not @map.solid?(@x + offs_x, @y + offs_y - @height + 5)
  end
end