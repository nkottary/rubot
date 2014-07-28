class EndGameHandler
	class << self

		LEVEL_X, LEVEL_Y = 100, 100
		SCORE_X, SCORE_Y = 100, 300
		LEVEL_COLOR = 0xff5500aa
		SCORE_COLOR = 0xff55aa00

		def initialize(onFinish)
			@onFinish = onFinish
		end

		def button_down(id)
			@onFinish.call
		end

		def update
		end

		def draw
			if NUM_OF_LEVELS == GameManager::currentLevel + 1
				FontLibrary::mediumFont.draw("WORLD COMPLETED", \
					LEVEL_X, LEVEL_Y - 50, ZOrder::UI, 1.0, 1.0, LEVEL_COLOR)
			end
			FontLibrary::mediumFont.draw("LEVEL #{GameManager::currentLevel + 1} COMPLETED", \
				LEVEL_X, LEVEL_Y, ZOrder::UI, 1.0, 1.0, LEVEL_COLOR)
	      	FontLibrary::mediumFont.draw("SCORE: #{ScoreBoard::score}", \
	      		SCORE_X, SCORE_Y, ZOrder::UI, 1.0, 1.0, SCORE_COLOR)
		end
	end
end
