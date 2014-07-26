require_relative 'helpers'
require_relative 'Collidable'

#Super class for player and all bots.
class Creature < Collidable

  @@vel_x = 2

  attr_reader :x, :y

  def initialize(x, y)
    # This always points to the frame that is currently drawn.
    # This is set in update, and used in draw.
    super x, y, 50, 50, :right # width and height 50 50
    @vy = 0
  end

  def reverse
    @dir = @dir == :right ? :left : :right
  end

  # Could the object be placed at x + offs_x/y + offs_y without being stuck?
  def would_fit(offs_x, offs_y)
    # Check at the center/top and center/bottom for map collisions
    not @@map.solid?(@x + offs_x + (@width / 2), @y + offs_y) and 
      not @@map.solid?(@x + offs_x - (@width / 2), @y + offs_y) and
      not @@map.solid?(@x + offs_x, @y + offs_y - @height + 5)
  end
end