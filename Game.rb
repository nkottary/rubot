require_relative "ParallaxBackground"
require_relative "ScrollingCamera"
require_relative "BotHandler"
require_relative "FireballHandler"
require_relative "DiamondHandler"
require_relative "PlayerDiamondCollider"
require_relative "ScoreBoard"
require_relative "PlayerHandler"
require_relative "Map"

class Game
    class << self
    	def initialize(mapFile)
            ScrollingCamera::initialize
            BotHandler::initialize
        	FireballHandler::initialize
        	DiamondHandler::initialize
            ScoreBoard::initialize

            Map::initialize mapFile
            PlayerDiamondCollider::initialize
            ParallaxBackground::initialize
    	end

    	def draw
    		ParallaxBackground::draw

            ScrollingCamera::translateAndDraw do 
                Map::draw
                PlayerHandler::draw
                BotHandler::draw
                FireballHandler::draw
                DiamondHandler::draw
            end

            ScoreBoard::draw
    	end

    	def update
            ParallaxBackground::update
            ScrollingCamera::update
            PlayerHandler::update
            BotHandler::update
            FireballHandler::update
            DiamondHandler::update

            PlayerDiamondCollider::update
    	end

    	def button_up(id)
            PlayerHandler::button_up id
        end

        def button_down(id)
            if id == Gosu::KbSpace
                FireballHandler::spawn PlayerHandler::playerObj.x, PlayerHandler::playerObj.y, PlayerHandler::playerObj.dir
            else
                PlayerHandler::button_down id
            end
        end

        def isWon?
            DiamondHandler::allGemsCollected?
        end
    end
end