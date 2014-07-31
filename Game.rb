require_relative "ParallaxBackground"
require_relative "ScrollingCamera"
require_relative "BotHandler"
require_relative "FireballHandler"
require_relative "DiamondHandler"
require_relative "ExplosionHandler"
require_relative "HealthPowerupHandler"
require_relative "PlayerHandler"
require_relative "CollisionHandler"
require_relative "ScoreBoard"
require_relative "Map"

class Game
    class << self
    	def initialize(mapFile)
            ScrollingCamera::initialize
            BotHandler::initialize
        	FireballHandler::initialize
        	DiamondHandler::initialize
            ExplosionHandler::initialize
            HealthPowerupHandler::initialize
            ScoreBoard::initialize

            Map::initialize mapFile
            CollisionHandler::initialize
            ParallaxBackground::initialize

            @waiting = 0
    	end

    	def draw
    		ParallaxBackground::draw

            ScrollingCamera::translateAndDraw do 
                Map::draw
                PlayerHandler::draw if PlayerHandler::playerObj.is_alive?
                BotHandler::draw
                FireballHandler::draw
                DiamondHandler::draw
                ExplosionHandler::draw
                HealthPowerupHandler::draw
            end

            ScoreBoard::draw
    	end

    	def update
            ParallaxBackground::update
            ScrollingCamera::update
            BotHandler::update
            FireballHandler::update
            DiamondHandler::update
            ExplosionHandler::update
            HealthPowerupHandler::update

            CollisionHandler::update

            if PlayerHandler::playerObj.is_alive?
                PlayerHandler::update
            else
                if @waiting == 0
                    ExplosionHandler::spawn(PlayerHandler::playerObj.x, PlayerHandler.playerObj.y)
                    @waiting += 1
                elsif @waiting == 100
                    PlayerHandler::reincarnate
                    @waiting = 0
                else
                    @waiting += 1
                end
            end
=begin
            if game_over_shown_flag and not @playerObj.is_alive?
                GameSounds::explosion_sound.play
                ExplosionHandler::spawn playerObj.x, playerObj.y
                game_over_shown_flag = 
            end
=end
    	end

    	def button_up(id)
            PlayerHandler::button_up id
        end

        def button_down(id)
            return if not PlayerHandler::playerObj.is_alive?
            if id == Gosu::KbSpace
                FireballHandler::spawn PlayerHandler::playerObj.x, PlayerHandler::playerObj.y, PlayerHandler::playerObj.dir
                GameSounds::shoot_sound.play
            else
                PlayerHandler::button_down id
            end
        end

        def isWon?
            DiamondHandler::allGemsCollected?
        end
    end
end