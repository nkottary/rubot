class PlayerHandler
    class << self
        attr_reader :playerObj

        def initialize(x, y)
            @playerObj = Player.new x, y
        end

        def draw
            @playerObj.draw
        end

        def update
            @playerObj.update
        end

        def button_up(id)
            if id == Gosu::KbLeft or id == Gosu::KbRight then
                @playerObj.stop
            elsif id == Gosu::KbUp then
                @playerObj.stop_jump
            end
        end

        def button_down(id)
            case id
                when Gosu::KbRight
                    @playerObj.move_right
                when Gosu::KbLeft
                    @playerObj.move_left
                when Gosu::KbUp
                    @playerObj.jump
            end
        end
    end

    private
    class Player < Creature

        JUMP_VEL = 20
        MOVE_VEL = 5

        WIDTH = 64
        HEIGHT = 40

        def initialize(x, y)
            super x, y, WIDTH, HEIGHT

            imgs = GameImages::playerImages

            @@stand_image = imgs[0]
            @@img_run = [imgs[2], imgs[3], imgs[2], imgs[1]]
            @@going_up_image = imgs[10]
            @@going_down_image = imgs[11]
            @@jump_n_move = imgs[5]

            @move_state = :standing
        end

        def update
            if @move_state == :moving then
                leftRightMove MOVE_VEL
            end
            moveVertically
            pickImage
        end
        
        def jump
            if @vert_state == :standing then
                @vert_state = :jumping
                @curr_yvel = JUMP_VEL
            end
        end

        def stop_jump
            if @vert_state == :jumping then
                @vert_state = :falling
                @curr_yvel = 0
            end
        end

        def move_right
            @move_state = :moving
            @dir = :right
        end

        def move_left
            @move_state = :moving
            @dir = :left
        end

        def stop
            @move_state = :standing
        end
        
        private

        def pickImage
            # Select image depending on state
            if @move_state == :standing then

                if @vert_state == :standing
                    @cur_image = @@stand_image
                elsif @vert_state == :falling
                    @cur_image = @@going_down_image
                elsif @vert_state == :jumping
                    @cur_image = @@going_up_image
                end

            elsif @vert_state == :standing then
                @cur_image = @@img_run[Gosu::milliseconds / 175 % @@img_run.size]  
            else
                @cur_image = @@jump_n_move
            end
        end

        def handleJumping
            if @curr_yvel == 0 or broadLineTouchUp?(@curr_yvel) 
                @curr_yvel = 0 
                @vert_state = :falling
            else
                @curr_yvel -= 1
            end
        end

        def moveVertically
            case @vert_state
                when :jumping
                    handleJumping 
                when :falling
                    handleFalling
                when :standing 
                    handleStanding
            end
        end
    end
end

