require_relative 'helpers'
require_relative 'Creature'

#A bot that ossilates between bricks.
class Bot < Creature

  @@botList = []
  @@imgs_run = []
  @@width = 80
  @@height = 80

  def self.init(window)
    8.times do |i|
      str = 'media/orc/run/run00' + (i + 1).to_s + '.png'
      @@imgs_run << Image.new(window, str, false)
    end
  end

  def self.reset
    @@botList = []
  end

  def self.spawn(x, y)
    @@botList << Bot.new(x, y)
  end

  def self.update
    @@botList.each do |bot|
      bot.update
    end
  end

  def self.draw
    @@botList.each do |bot|
      bot.draw
    end
  end

  def update
    @cur_image = @@imgs_run[milliseconds / 100 % 8]
    
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