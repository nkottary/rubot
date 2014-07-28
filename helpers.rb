NUM_OF_LEVELS = 2

module Tiles
  Grass = 0
  Earth = 1
end

module ZOrder
  Background, Map, Diamond, CptnRuby, Creature, UI = *0..5 
end

class FontLibrary
	class << self
		attr_reader :smallFont, :mediumFont, :bigFont

		def load(window)
			@smallFont = Gosu::Font.new(window, Gosu::default_font_name, 20)
			@mediumFont = Gosu::Font.new(window, Gosu::default_font_name, 40)
	    	@bigFont = Gosu::Font.new(window, Gosu::default_font_name, 100)
		end
	end
end

class GameImages
	class << self
=begin
		instance_variables.each do |var|
			attr_reader var
		end
=end
		attr_reader :menuBackground, :gameBackground, :arrowImage, :tileset, :fireballImage, :diamondImage
		attr_reader :playerImages, :orc_run_imgs

		def load(window)
			@menuBackground = Gosu::Image.new(window, 'media/menu-bg.jpg', true)
			@gameBackground = Gosu::Image.new(window, "media/sky_bg.png", true)
			@arrowImage = Gosu::Image.new(window, 'media/arrow.png', true)
			@tileset = Gosu::Image.load_tiles(window, "media/CptnRuby Tileset.png", 60, 60, true)
			@fireballImage = Gosu::Image.new(window, 'media/fireball.png', false)
			@diamondImage = Gosu::Image.new(window, 'media/gem.png', false)
			@playerImages = Gosu::Image.load_tiles(window, "media/hero.png", 64, 64, false)

			@orc_run_imgs = []
			8.times do |i|
		      	str = 'media/orc/run/run00' + (i + 1).to_s + '.png'
		      	@orc_run_imgs << Gosu::Image.new(window, str, false)
		    end
		end
	end
end