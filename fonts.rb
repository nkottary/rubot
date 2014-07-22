class Fonts
	attr_reader :bigFont, :smallFont, :mediumFont
	def initialize(window)
		@smallFont = Gosu::Font.new(window, Gosu::default_font_name, 20)
		@mediumFont = Gosu::Font.new(window, Gosu::default_font_name, 40)
    	@bigFont = Gosu::Font.new(window, Gosu::default_font_name, 100)
	end
end