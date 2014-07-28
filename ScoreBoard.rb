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
		end
	end
end
