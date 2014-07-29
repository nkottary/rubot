require_relative "ParallaxBackground"
require_relative "ScrollingCamera"
require_relative "BotHandler"
require_relative "FireballHandler"
require_relative "DiamondHandler"
require_relative "ExplosionHandler"
require_relative "HealthPowerupHandler"
require_relative "PlayerHandler"

require_relative "PlayerDiamondCollider"
require_relative "PlayerEnemyCollider"
require_relative "FireballEnemyCollider"
require_relative "PlayerHealthPowerupCollider"
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
            PlayerDiamondCollider::initialize
            PlayerEnemyCollider::initialize
            FireballEnemyCollider::initialize
            PlayerHealthPowerupCollider::initialize
            ParallaxBackground::initialize
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
            PlayerHandler::update
            BotHandler::update
            FireballHandler::update
            DiamondHandler::update
            ExplosionHandler::update
            HealthPowerupHandler::update

            PlayerDiamondCollider::update
            PlayerEnemyCollider::update
            FireballEnemyCollider::update
            PlayerHealthPowerupCollider::update
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