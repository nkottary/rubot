require_relative 'helpers'

class Diamond < Collidable

  @@diamondList = []
  @@image = nil

  def self.init(window)
    @@image = Image.new(window, 'media/gem.png', false)
  end

  def self.reset
    @@diamondList = []
  end

  def self.spawn(x, y)
    @@diamondList << Diamond.new(x, y)
  end

  def self.getDiamondList
    @@diamondList
  end

  def self.update
    @@diamondList.each do |diamond|
      diamond.update
    end
  end

  def self.draw
    @@diamondList.each do |diamond|
      diamond.draw
    end
  end

  def self.allGemsCollected?
    @@diamondList.empty?
  end

  def initialize(x, y)
    super x, y, 50, 50, nil
    @angle = 0
  end

  def update
    @angle = 25 * Math.sin(milliseconds / 133.7)
  end

  def draw
    # Draw, slowly rotating
    @@image.draw_rot(@x, @y, ZOrder::Diamond, @angle)
  end
end