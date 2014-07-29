require_relative "Creature"

class BotHandler
    class << self
        attr_reader :botList
        def initialize
            @botList = []        
        end

        def spawn(x, y)
            @botList << Bot.new(x, y)
        end

        def update
            @botList.reject! do |bot|
                bot.update
                if not bot.is_alive?
                    ExplosionHandler::spawn bot.x, bot.y
                    GameSounds::explosion_sound.play
                    true
                end
            end
        end

        def draw
            @botList.each do |bot|
              bot.draw
            end
        end
    end

    private

    class Bot < Creature

        WIDTH = 60
        HEIGHT = 60
        VEL_X = 2
        MAX_HEALTH = 5

        def initialize(x, y)
            super x, y, WIDTH, HEIGHT, MAX_HEALTH
            @vert_state = :standing
            @curr_yvel = 0
            @health = MAX_HEALTH
        end

        def update
            @cur_image = GameImages::orc_run_imgs[Gosu::milliseconds / 100 % 8]
            moveHorizontally
            moveVertically
        end

        def damage(amount)
            @health -= amount if is_alive?
            GameSounds::orc_ouch.play
        end

        private

        def moveHorizontally
            reverse if leftRightMove VEL_X
        end 

        def moveVertically
            if @vert_state == :falling
                handleFalling
            elsif @vert_state == :standing
                handleStanding 
            end
        end     
    end

    class NoFallBot < Bot
        def update
            super
            off_x = @dir == :right ? VEL_X : -VEL_X
            if not broadTouchDown?(@x + off_x, @y + 1)
                reverse
            end
        end
    end
end