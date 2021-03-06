class ScoreBoard
	class << self
		attr_reader :score

		def initialize
			@score = 0
		end

		def increment
			@score += 1
		end

		def draw
			FontLibrary::smallFont.draw("Score: #{@score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff990000)
			FontLibrary::smallFont.draw("Health: #{PlayerHandler::playerObj.health}", 10, 30, ZOrder::UI, 1.0, 1.0, 0xff990000)
			FontLibrary::smallFont.draw("Lives: #{PlayerHandler::playerObj.lives}", 10, 50, ZOrder::UI, 1.0, 1.0, 0xff990000)
		end
	end
end
