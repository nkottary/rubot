# Basically, the tutorial game taken to a jump'n'run perspective.

# Shows how to
#  * implement jumping/gravity
#  * implement scrolling using Window#translate
#  * implement a simple tile-based map
#  * load levels from primitive text files

# Some exercises, starting at the real basics:
#  0) understand the existing code!
# As shown in the tutorial:
#  1) change it use Gosu's Z-ordering---- done
#  2) add gamepad support
#  3) add a score as in the tutorial game ---- done
#  4) similarly, add sound effects for various events
# Exploring this game's code and Gosu:
#  5) make the player wider, so he doesn't fall off edges as easily
#  6) add background music (check if playing in Window#update to implement 
#     looping)
#  7) implement parallax scrolling for the star background! --- done
# Getting tricky:
#  8) optimize Map#draw so only tiles on screen are drawn (needs modulo, a pen
#     and paper to figure out)
#  9) add loading of next level when all gems are collected
# ...Enemies, a more sophisticated object system, weapons, title and credits
# screens...

require 'rubygems'
require 'gosu'
require_relative 'helpers'
require_relative 'Diamond'
require_relative 'Bot'
require_relative 'NoFallBot'
require_relative 'ParallaxBackground'
require_relative 'Map'
require_relative 'CptnRuby'
require_relative 'fonts'
require_relative 'PauseHandler'

include Gosu

class Game < Window
  attr_reader :map

  def initialize
    super(640, 480, false)
    self.caption = "Cptn. Ruby"

    @map = Map.new(self, "media/CptnRuby Map.txt")

    @parallax_bg = ParallaxBackground.new(self, "media/sky_bg.png", (@map.width + 15) * 50, (@map.height + 10) * 50)

    @cptn = CptnRuby.new(self, 400, 100)#1474, 999)

    # The scrolling position is stored as top left corner of the screen.
    @camera_x = @camera_y = 0

    @fonts = Fonts.new(self)
    @pauseHandler = PauseHandler.new(self, @fonts)

    @bot = NoFallBot.new(self, 400, 100)#1474, 999)

    @gameState = :playing
  end

  def update

    if @gameState == :playing then
      @bot.update
      @map.gems.each {|g| g.update}

      @cptn.update
      @cptn.collect_gems(@map.gems)

      # Scrolling follows player
      @camera_x = [[@cptn.x - 320, 0].max, @map.width * 50 - 640].min
      @camera_y = [[@cptn.y - 240, 0].max, @map.height * 50 - 480].min

      @parallax_bg.update @camera_x, @camera_y
    elsif @gameState == :paused then
      @pauseHandler.update
    end
  end

  def draw

    @parallax_bg.draw

    translate(-@camera_x, -@camera_y) do
      @map.draw
      @cptn.draw
      @bot.draw
    end

    @fonts.smallFont.draw("Score: #{@cptn.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff990000)

    if @gameState == :paused
      @pauseHandler.draw
    end
  end

  def button_up(id)
    if id == KbLeft or id == KbRight then
      @cptn.stop
    elsif id == KbUp then
      @cptn.stop_jump
    end
  end

  def doPauseAction

    option = @pauseHandler.getSelection

    if option == :yes then close
    elsif option == :no then @gameState = :playing 
    end

  end

  def button_down(id)
    if @gameState == :paused 

      if id == KbEscape then @gameState = :playing
      elsif id == KbRight or id == KbLeft then @pauseHandler.toggle
      elsif id == KbReturn then doPauseAction 
      end

    elsif @gameState == :playing

      if id == KbEscape then @gameState = :paused
      elsif id == KbRight then @cptn.move_right
      elsif id == KbLeft then @cptn.move_left
      elsif id == KbUp then @cptn.jump 
      end

    end
  end
end

Game.new.show
