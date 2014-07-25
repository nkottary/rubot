require_relative 'Collidable'

class Fireball < Collidable

	attr_reader :is_alive

	VEL_X = 10
	VEL_Y = 10
	@@map = nil
	@@image = nil

	@@fireballList = []

	def self.init(window, map)
		@@map = map
		@@image = Image.new(window, 'media/fireball.png', false)
	end

	def self.spawn(x, y, dir)
		@@fireballList << Fireball.new(x, y, dir)
	end

	def self.update
		@@fireballList.reject! do |fireball|
			fireball.update
			not fireball.is_alive
		end
	end

	def self.draw
		@@fireballList.each do |fireball|
			fireball.draw
		end
	end

	def initialize(x, y, dir)
		super x, y, 30, 30, @@map, dir
		@cur_image = @@image
		@is_alive = true
		@curr_yvel = 0
		@vert_state = :up
	end

	# over-ride these functions so that they detect only strictly right tiles.

	def brickTouchLeft?(newx, newy)
		@map.solid?(newx - @width / 2, newy) 
	end

	def brickTouchRight?(newx, newy)
		@map.solid?(newx + @width / 2, newy) 
	end

	def moveHorizontally
		if (@dir == :right and lineTouchRight?(VEL_X)) \
					or 
				(@dir == :left and lineTouchLeft?(VEL_X))
					@is_alive = false 
		end	
	end

	def moveVertically
		if @vert_state == :up 

			if lineTouchUp?(@curr_yvel) or @curr_yvel == 0
				@vert_state = :down
			else
				@curr_yvel -= 1
			end

		elsif @vert_state == :down

			if lineTouchDown?(@curr_yvel)
				@vert_state = :up
				@curr_yvel = VEL_Y
			else
				@curr_yvel += 1
			end
		end
	end

	def update
		moveHorizontally
		moveVertically
	end
end