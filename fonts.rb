class Fonts
	@@smallFont = @@mediumFont = @@bigFont = nil
	def self.init(window)
		@@smallFont = Gosu::Font.new(window, Gosu::default_font_name, 20)
		@@mediumFont = Gosu::Font.new(window, Gosu::default_font_name, 40)
    	@@bigFont = Gosu::Font.new(window, Gosu::default_font_name, 100)
	end

	def self.smallFont
		@@smallFont
	end
	
	def self.mediumFont
		@@mediumFont
	end

	def self.bigFont
		@@bigFont
	end
end