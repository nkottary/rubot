class PlayerHandler
    class << self
        attr_reader :playerObj

        def initialize(x, y)
            @start_x, @start_y = x, y
            @playerObj = Player.new x, y
        end

        def reincarnate
            @playerObj.reincarnate @start_x, @start_y
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
                    GameSounds::jump_sound.play
            end
        end
    end

    private
    class Player < Creature

        JUMP_VEL = 20
        MOVE_VEL = 5

        WIDTH = 64
        HEIGHT = 40

        MAX_HEALTH = 100
        NUM_LIVES = 3
        IMMUNE_TIME = 100 # after being damaged player remains immune for this much time

        attr_reader :health, :lives

        def initialize(x, y)
            super x, y, WIDTH, HEIGHT, MAX_HEALTH

            @move_state = :standing
            @walk_sound = nil

            @elapsed_imm_time = 0
            @lives = NUM_LIVES
        end

        def reincarnate(x, y)
            @x, @y = x, y 
            @dir = :right
            @lives -= 1
            @move_state = :standing
            @walk_sound = nil
            @elapsed_imm_time = 0
            @health = MAX_HEALTH
        end

        def draw
            # Flip vertically when facing to the left.
            return if not @cur_image

            if @dir == :left then
                offs_x = @width / 2
                factor = -1.0
            else
                offs_x = -@width / 2
                factor = 1.0
            end

            x = @x + offs_x
            y = @y - @height + 1

            if @elapsed_imm_time % 5 > 0 && @elapsed_imm_time % 6 < 4 
                @cur_image.draw(x, y, ZOrder::Creature, factor, 1.0, 0xaaffffff, :default)
            else
                @cur_image.draw(x, y, ZOrder::Creature, factor, 1.0)
            end
        end

        def damage(amount)
            if not is_immune?
                @health -= amount 
                @elapsed_imm_time = IMMUNE_TIME
                GameSounds::rubot_ouch.play
            end
        end

        def heal(amount)
            @health += @health + amount
            @health = MAX_HEALTH if @health > MAX_HEALTH
        end

        def update
            if @move_state == :moving then
                leftRightMove MOVE_VEL
                if @walk_sound == nil or not @walk_sound.playing?
                    @walk_sound = GameSounds::walking_sound.play
                end
            end
            moveVertically
            pickImage
            tick
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
                    @cur_image = GameImages::player_stand_image
                elsif @vert_state == :falling
                    @cur_image = GameImages::player_going_down_image
                elsif @vert_state == :jumping
                    @cur_image = GameImages::player_going_up_image
                end

            elsif @vert_state == :standing then
                @cur_image = GameImages::player_img_run[Gosu::milliseconds / 175 % GameImages::player_img_run.size]  
            else
                @cur_image = GameImages::player_jump_n_move
            end
        end

        def handleJumping
            if @curr_yvel == 0 or narrowLineTouchUp?(@curr_yvel) 
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

        def is_immune?
            @elapsed_imm_time > 0
        end

        def tick
            @elapsed_imm_time -= 1 if @elapsed_imm_time != 0
        end
    end
end

