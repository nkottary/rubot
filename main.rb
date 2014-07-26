
#  8) optimize Map#draw so only tiles on screen are drawn (needs modulo, a pen
#     and paper to figure out)

require 'gosu'
require_relative 'helpers'
require_relative 'Collidable'
require_relative 'Bot'
require_relative 'NoFallBot'
require_relative 'ParallaxBackground'
require_relative 'Map'
require_relative 'Player'
require_relative 'fonts'
require_relative 'PauseHandler'
require_relative 'Fireball'
require_relative 'PlayerDiamondCollider'
require_relative 'Menu'
require_relative 'Game'

include Gosu

class GameWindow < Window

    def initialize
        super(640, 480, false)
        @levelMaps = ["media/level1.txt", "media/level2.txt", "media/level3.txt", "media/level4.txt"]
        self.caption = "Rubot"
        Fonts::init self
        @menu = Menu.new(self, "media/menu-bg.jpg", "Rubot", 
            ["Start game", "High scores", "Change controls", "Quit"])
        @lastLevel = 4
        @currentLevel = 0
        @windowState = :menu
        @game = Game.new self, @levelMaps[0]
    end

    def startNewGame
        @currentLevel = 0
        @windowState = :game
        startLevel
    end

    def startLevel
        p @currentLevel
        @game.reset @levelMaps[@currentLevel]
    end

    def update
        if @windowState == :menu then
            @menu.update
        elsif @windowState == :game then
            @game.update
            @windowState = :menu if @game.userQuit?
            if Diamond::allGemsCollected?
                @currentLevel += 1 if @currentLevel < @lastLevel
                startLevel
            end
        end
    end

    def draw
        if @windowState == :menu then
            @menu.draw
        elsif @windowState == :game then
            @game.draw
        end
    end

    def button_up(id)
        if @windowState == :game then
            @game.button_up id
        end
    end

    def doMenuAction
        case @menu.selectedOption
        when 0
            startNewGame
        when 3
            close
        end
    end

    def handleMenuKeys(key)
        case key
        when KbUp
            @menu.previousOption
        when KbDown
            @menu.nextOption
        when KbReturn
            doMenuAction
        when KbEscape
            close
        end
    end

    def button_down(id)    
        if @windowState == :menu
            handleMenuKeys(id)
        elsif @windowState == :game
            @game.button_down(id)
        end
    end
end

GameWindow.new.show
