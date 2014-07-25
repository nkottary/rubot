require_relative 'Arrow'

class PauseHandler

	attr_reader :selectedOption

	def initialize(window)
		@quitX, @quitY = 200, 150
		@yesX, @yesY = @quitX, @quitY + 100
		@noX, @noY = @quitX + 190, @yesY

		@selectedOption = :yes
		@arrow = Arrow.new(window, 100) # 100 is arrow offset
	
		@arrow.set(@yesX, @yesY)

		@color = 0xff5500aa
	end

	def toggle
		if @selectedOption == :yes
			@selectedOption = :no
			@arrow.set(@noX, @noY)
		elsif @selectedOption == :no
			@selectedOption = :yes
			@arrow.set(@yesX, @yesY)
		end
	end

	def getSelection
		@selectedOption
	end

	def update
		@arrow.update
	end

	def draw
		Fonts::bigFont.draw("Quit?", @quitX, @quitY, ZOrder::UI, 1.0, 1.0, @color)
      	Fonts::mediumFont.draw("Yes", @yesX, @yesY, ZOrder::UI, 1.0, 1.0, @color)
      	Fonts::mediumFont.draw("No", @noX, @noY, ZOrder::UI, 1.0, 1.0, @color)
      	@arrow.draw
	end
end
