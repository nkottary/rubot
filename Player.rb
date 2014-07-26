require_relative 'helpers'
require_relative 'Creature'

# Player class.
class Player < Creature
  attr_accessor :score

  @@jump_vel = 20
  @@move_vel = 5

  def self.position(x, y)
    @@start_x, @@start_y = x, y
  end

  def self.init(window)
    imgs = Image.load_tiles(window, "media/hero.png", 64, 64, false)

    @@stand_image = imgs[0]
    @@img_run = [imgs[2], imgs[3], imgs[2], imgs[1]]
    @@going_up_image = imgs[10]
    @@going_down_image = imgs[11]
    @@jump_n_move = imgs[5]
  end

  def initialize
    super @@start_x, @@start_y

    @score = 0
    @height = 64
    @width = 40

    @jump_state = :onground
    @move_state = :standing
  end
  
  def pickImage
    # Select image depending on state
    if @move_state == :standing then

      if @jump_state == :onground
        @cur_image = @@stand_image
      elsif @jump_state == :down
        @cur_image = @@going_down_image
      elsif @jump_state == :up
        @cur_image = @@going_up_image
      end

    elsif @jump_state == :onground then
      @cur_image = @@img_run[milliseconds / 175 % @@img_run.size]  
    else
      @cur_image = @@jump_n_move
    end
  end

  def leftRightMove
     # Directional walking, horizontal movement
    if @dir == :right and would_fit(@@move_vel, 0) then @x += @@move_vel
    elsif @dir == :left and would_fit(-@@move_vel, 0) then @x -= @@move_vel
    end
  end

  def jumpOrFall

    if @jump_state == :up then

      if @vy == 0 
        @jump_state = :down
        return
      end

      if lineTouchUp?(@vy) 
        @vy = 0 
        @jump_state = :down
        return
      end

      @vy -= 1

    elsif @jump_state == :down then

      if lineTouchDown?(@vy)
        @vy = 0
        @jump_state = :onground 
        return
      end

      @vy += 1

    elsif @jump_state == :onground and not brickTouchDown?(@x, @y + 1) then @jump_state = :down
    end
  end

  def update()

    if @move_state == :moving then
      leftRightMove
    end
    
    jumpOrFall

    pickImage
  end
  
  def jump
    if @jump_state == :onground then
      @jump_state = :up
      @vy = @@jump_vel
    end
  end

  def stop_jump
    if @jump_state == :up then
      @jump_state = :down
      @vy = 0
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
end