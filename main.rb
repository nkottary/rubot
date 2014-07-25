
#  8) optimize Map#draw so only tiles on screen are drawn (needs modulo, a pen
#     and paper to figure out)

require 'gosu'
require_relative 'helpers'
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
        self.caption = "Rubot"
        @game = Game.new self
        Fonts::init self
        @menu = Menu.new(self, "media/menu-bg.jpg", "Rubot", 
            ["Start game", "High scores", "Change controls", "Quit"])
        @windowState = :menu
    end

    def startNewGame
        @game = Game.new self
        @windowState = :game
    end

    def update
        if @windowState == :menu then
            @menu.update
        elsif @windowState == :game then
            @game.update
            @windowState = :menu if @game.userQuit?
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
