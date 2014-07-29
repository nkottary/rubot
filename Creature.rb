require_relative "Collidable"
#Super class for player and all bots.
class Creature < Collidable
    attr_reader :x, :y

    def initialize(x, y, width, height, health)
        super x, y, width, height, :right # width and height 50 50

        @curr_yvel = 0
        @vert_state = :standing
        @health = health
    end

    def is_alive?
        @health > 0
    end

    protected
    def reverse
        @dir = @dir == :right ? :left : :right
    end

    protected
    def handleStanding
        if not broadTouchDown?(@x, @y + 1) then @vert_state = :falling end
    end

    protected
    def handleFalling
        if broadLineTouchDown?(@curr_yvel)
            @curr_yvel = 0
            @vert_state = :standing
        else
            @curr_yvel += 1
        end
    end
end