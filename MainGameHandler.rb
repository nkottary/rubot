require 'gosu'
require_relative 'helpers'
require_relative 'GameManager'
require_relative 'MenuHandler'

class MainGameHandler
    class << self
        attr_reader :window

        def initialize
            @window = GameWindow.new
        end

        def show
            @window.show
        end
    end

    private
    class GameWindow < Gosu::Window

        def initialize
            super(WINDOW_WIDTH, WINDOW_HEIGHT, false)
            self.caption = "Rubot"
            
            FontLibrary::load self
            GameImages::load self
            GameMusic::load self
            GameSounds::load self

            @windowState = :menu

            GameManager::initialize method(:quitGame)
            MenuHandler::initialize method(:startNewGame), method(:close)

            GameMusic::menu_music.play true
        end

        def update
            case @windowState
                when :menu
                    MenuHandler::update
                when :game
                    GameManager::update
            end
        end

        def startNewGame
            GameManager::startNewGame
            @windowState = :game 
            GameMusic::in_game_music.play true
        end

        def quitGame
            @windowState = :menu
            GameMusic::menu_music.play true
        end

        def draw
            case @windowState
                when :menu
                    MenuHandler::draw
                when :game
                    GameManager::draw
            end
        end

        def button_up(id)
            case @windowState
                when :game
                    GameManager::button_up id
            end
        end

        def button_down(id)    
            case @windowState
                when :menu
                    MenuHandler::button_down id
                when :game
                    GameManager::button_down id
            end
        end
    end
end
