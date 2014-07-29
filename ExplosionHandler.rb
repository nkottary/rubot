class ExplosionHandler
	class << self

		attr_reader :explosionList

		def initialize
			@explosionList = []
		end

		def spawn(x, y)
			@explosionList << Explosion.new(x, y)
		end

		def update
			@explosionList.reject! do |explosion|
				explosion.update
				not explosion.is_alive?
			end
		end

		def draw
			@explosionList.each do |explosion|
				explosion.draw
			end
		end
	end

	private
	class Explosion < Collidable

		VEL_X = 10
		VEL_Y = 10

		EXPLOSION_TIME = 100

		def initialize(x, y)
			@x = x
			@y = y
			@cur_image = GameImages::explosionImages[0]
			@elapsed_time = 0
		end

		def is_alive?
			@elapsed_time < EXPLOSION_TIME
		end

		def draw
			@cur_image.draw(@x - 60, @y - 60, ZOrder::UI)
		end

		def update
			@elapsed_time += 1
			len = GameImages::explosionImages.length
			@cur_image = GameImages::explosionImages[Gosu::milliseconds / 100 % len]
		end
	end
end