require_relative 'Arrow'

class Menu

	attr_reader :selectedOption

	def initialize(window, backgroundImage, title, options)
		@backgroundImage = Image.new(window, backgroundImage, false)
		@title = title 

		@options = options 
		@numOptions = options.length

		@title_x, @title_y = 180, 100
		@title_color = 0xffffaa00
		@option_color = 0xffffff00

		@spacing = 50

		@arrow = Arrow.new window, 100
		@arrow.set @title_x, @title_y + 100

		@selectedOption = 0
	end

	def nextOption
		@selectedOption += 1
		@selectedOption = 0 if @selectedOption >= @numOptions
		@arrow.set(*getOptionPosition(@selectedOption))
	end

	def previousOption
		@selectedOption -= 1
		@selectedOption = @numOptions - 1 if @selectedOption < 0
		@arrow.set(*getOptionPosition(@selectedOption))
	end

	def getOptionPosition(num)
		return @title_x, @title_y + 100 + num * @spacing
	end

	def draw
		@backgroundImage.draw 0, 0, ZOrder::Background
		Fonts::bigFont.draw(@title, @title_x, @title_y, ZOrder::UI, 1.0, 1.0, @title_color)

		@numOptions.times do |index|
			x ,y = getOptionPosition index
			Fonts::mediumFont.draw(@options[index], x, y, ZOrder::UI, 1.0, 1.0, @option_color)
		end

		@arrow.draw
	end

	def update
		@arrow.update
	end
end