require_relative "Creature"

class BotHandler
    class << self
        def initialize
            @botList = []        
        end

        def spawn(x, y)
            @botList << Bot.new(x, y)
        end

        def update
            @botList.each do |bot|
              bot.update
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

        def initialize(x, y)
            super x, y, WIDTH, HEIGHT
            @vert_state = :standing
            @curr_yvel = 0
        end

        def update
            @cur_image = GameImages::orc_run_imgs[Gosu::milliseconds / 100 % 8]
            moveHorizontally
            moveVertically
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