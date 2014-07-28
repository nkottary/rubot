require_relative "Arrow"

class Menu

	TITLE_STRING = "Rubot"
	TITLE_X, TITLE_Y = 180, 50
	TITLE_COLOR = 0xffffaa00

	HEADER_X, HEADER_Y = 180, 150
	HEADER_COLOR = 0xffff0000

	OPTION_X, OPTION_Y = 180, 200
	OPTION_SPACING = 50
	OPTION_COLOR = 0xffffff00

	ARROW_X_OFFSET = 100

	attr_reader :selectedOption

	def initialize(header, options, actions)
		@header = header
		@options = options 
		@actions = actions
		@numOptions = options.length 
		@arrow = Arrow.new ARROW_X_OFFSET
		@arrow.set OPTION_X, OPTION_Y
		@selectedOption = 0
	end

	def nextOption
		@selectedOption += 1
		@selectedOption = 0 if @selectedOption >= @numOptions
		@arrow.set(OPTION_X, getOptionY(@selectedOption))
	end

	def previousOption
		@selectedOption -= 1
		@selectedOption = @numOptions - 1 if @selectedOption < 0
		@arrow.set(OPTION_X, getOptionY(@selectedOption))
	end

	def doAction
		do_i_th_action(@selectedOption)
	end

	def goBack
		do_i_th_action(-1)
	end

	def draw
		GameImages::menuBackground.draw 0, 0, ZOrder::Background
		FontLibrary::bigFont.draw(TITLE_STRING, TITLE_X, TITLE_Y, ZOrder::UI, 1.0, 1.0, TITLE_COLOR)
		FontLibrary::mediumFont.draw(@header, HEADER_X, HEADER_Y, ZOrder::UI, 1.0, 1.0, HEADER_COLOR)

		@numOptions.times do |index|
			x = OPTION_X
			y = getOptionY index
			FontLibrary::mediumFont.draw(@options[index], x, y, ZOrder::UI, 1.0, 1.0, OPTION_COLOR)
		end

		@arrow.draw
	end

	def update
		@arrow.update
	end

	private
	def getOptionY(num)
		OPTION_Y + num*OPTION_SPACING
	end

	def do_i_th_action(i)
		@actions[i].call if @actions[i]
	end
end