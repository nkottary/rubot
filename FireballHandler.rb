class FireballHandler
	class << self
		def initialize
			@fireballList = []
		end

		def spawn(x, y, dir)
			@fireballList << Fireball.new(x, y, dir)
		end

		def update
			@fireballList.reject! do |fireball|
				fireball.update
				not fireball.is_alive
			end
		end

		def draw
			@fireballList.each do |fireball|
				fireball.draw
			end
		end
	end

	private
	class Fireball < Collidable
		attr_reader :is_alive

		VEL_X = 10
		VEL_Y = 10

		def initialize(x, y, dir)
			super x, y, 20, 20, dir
			@cur_image = GameImages::fireballImage
			@is_alive = true
			@curr_yvel = 0
			@vert_state = :up
		end

		def moveHorizontally
			@is_alive = false if leftRightMove VEL_X
		end

		def moveVertically
			if @vert_state == :up 
				if broadLineTouchUp?(@curr_yvel) or @curr_yvel == 0
					@vert_state = :down
				else
					@curr_yvel -= 1
				end
			elsif @vert_state == :down
				if broadLineTouchDown?(@curr_yvel)
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
end