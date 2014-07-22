require_relative 'helpers'
require_relative 'Creature'

# Player class.
class CptnRuby < Creature
  attr_reader :score

  @@jump_vel = 20
  @@move_vel = 5

  def initialize(window, x, y)
    super window, x, y
    imgs = Image.load_tiles(window, "media/hero.png", 64, 64, false)

    @stand_image = imgs[0]
    @img_run = [imgs[2], imgs[3], imgs[2], imgs[1]]
    @going_up_image = imgs[10]
    @going_down_image = imgs[11]
    @jump_n_move = imgs[5]

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
        @cur_image = @stand_image
      elsif @jump_state == :down
        @cur_image = @going_down_image
      elsif @jump_state == :up
        @cur_image = @going_up_image
      end

    elsif @jump_state == :onground then
      @cur_image = @img_run[milliseconds / 175 % @img_run.size]  
    else
      @cur_image = @jump_n_move
    end
  end

  def leftRightMove
     # Directional walking, horizontal movement
    if @dir == :right then
      @@move_vel.times { if would_fit(1, 0) then @x += 1 end }
    else 
      @@move_vel.times { if would_fit(-1, 0) then @x -= 1 end }
    end
  end

  def jumpOrFall

    if @jump_state == :up then

      if @vy == 0 
        @jump_state = :down
        return
      end

      (-@vy).times { if would_fit(0, -1) then 
        @y -= 1 
      else 
        @vy = 0 
        @jump_state = :down
        return
      end }

      @vy += 1

    elsif @jump_state == :down then

      @vy.times { if would_fit(0, 1) then 
        @y += 1 
      else 
        @vy = 0
        @jump_state = :onground 
        return
      end }

      @vy += 1

    else
      if would_fit(0, 1) then
        @jump_state = :down
      end
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
      @vy = -@@jump_vel
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
  
  def collect_gems(gems)
    # Same as in the tutorial game.
    gems.reject! do |item|
      if (item.x - @x).abs < 50 and (item.y - @y).abs < 50 then
        @score += 1
        true
      else
        false
      end
    end
  end
end