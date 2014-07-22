require_relative 'helpers'
require_relative 'Creature'

#A bot that ossilates between bricks.
class Bot < Creature

  def initialize(window, x, y)
    super window, x, y

    #@imgs_idle = []
    @imgs_run = []
"""
    4.times do |i|
      str = 'media/orc/idle/idle00' + (i + 1).to_s + '.png'
      @imgs_idle << Image.new(window, str, false)
    end
"""
    8.times do |i|
      str = 'media/orc/run/run00' + (i + 1).to_s + '.png'
      @imgs_run << Image.new(window, str, false)
    end

    @width = 80
    @height = 80
  end

  def update
    @cur_image = @imgs_run[milliseconds / 100 % 8]
    '''
    if (@vy < 0)
      @cur_image = @jump
    end'''
    
    # Directional walking, horizontal movement
    if @dir == :right then
      @@vel_x.times { if would_fit(1, 0) then @x += 1 else @dir = :left end }
    elsif @dir == :left then
      @@vel_x.times { if would_fit(-1, 0) then @x -= 1 else @dir = :right end }
    end

    # Acceleration/gravity
    # By adding 1 each frame, and (ideally) adding vy to y, the player's
    # jumping curve will be the parabole we want it to be.
    @vy += 1
    if @vy > 0 then
      @vy.times { if would_fit(0, 1) then @y += 1 else @vy = 0 end }
    end
    if @vy < 0 then
      (-@vy).times { if would_fit(0, -1) then @y -= 1 else @vy = 0 end }
    end
  
  end
end