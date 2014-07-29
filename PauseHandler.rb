require_relative "Arrow"

class PauseHandler
	class << self
		attr_reader :selectedOption

		QUIT_X, QUIT_Y = 200, 150
		YES_X, YES_Y = QUIT_X, QUIT_Y + 100
		NO_X, NO_Y = QUIT_X + 190, YES_Y
		COLOR = 0xff5500aa

		def initialize(onYes, onNo)
			@selectedOption = :yes
			@arrow = Arrow.new 100 # 100 is arrow offset
			@arrow.set YES_X, YES_Y
			@onYes = onYes
			@onNo = onNo
		end

		def button_down(id)
			toggle if id == Gosu::KbLeft or id == Gosu::KbRight
			doAction if id == Gosu::KbReturn
		end

		def getSelection
			@selectedOption
		end

		def update
			@arrow.update
		end

		def draw
			FontLibrary::bigFont.draw("Quit?", QUIT_X, QUIT_Y, ZOrder::UI, 1.0, 1.0, COLOR)
	      	FontLibrary::mediumFont.draw("Yes", YES_X, YES_Y, ZOrder::UI, 1.0, 1.0, COLOR)
	      	FontLibrary::mediumFont.draw("No", NO_X, NO_Y, ZOrder::UI, 1.0, 1.0, COLOR)
	      	@arrow.draw
		end

		private
		
		def toggle
			if @selectedOption == :yes
				@selectedOption = :no
				@arrow.set NO_X, NO_Y
			elsif @selectedOption == :no
				@selectedOption = :yes
				@arrow.set YES_X, YES_Y
			end
			GameSounds::option_sound.play
		end

		def doAction
			if @selectedOption == :yes
				@onYes.call
			else
				@onNo.call
			end
			GameSounds::select_sound.play
		end
	end
end
