NUM_OF_LEVELS = 2
WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480

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
			@mediumFont = Gosu::Font.new(window, "media/Fonts/SkipLegDay.ttf", 40)
	    	@bigFont = Gosu::Font.new(window, "media/Fonts/MTF Toast.ttf", 100)
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
		attr_reader :playerImages, :orc_run_imgs, :explosionImages, :healthPowerupImage

		def load(window)
			@menuBackground = Gosu::Image.new(window, 'media/menu-bg.jpg', true)
			@gameBackground = Gosu::Image.new(window, "media/sky_bg.png", true)
			@arrowImage = Gosu::Image.new(window, 'media/arrow.png', true)
			@tileset = Gosu::Image.load_tiles(window, "media/CptnRuby Tileset.png", 60, 60, true)
			@fireballImage = Gosu::Image.new(window, 'media/fireball.png', false)
			@diamondImage = Gosu::Image.new(window, 'media/gem.png', false)
			@playerImages = Gosu::Image.load_tiles(window, "media/hero.png", 64, 64, false)
			@explosionImages = Gosu::Image.load_tiles(window, "media/Explosion.png", 96, 96, false)
			@healthPowerupImage = Gosu::Image.new(window, 'media/health.png', false)

			@orc_run_imgs = []
			8.times do |i|
		      	str = 'media/orc/run/run00' + (i + 1).to_s + '.png'
		      	@orc_run_imgs << Gosu::Image.new(window, str, false)
		    end
		end
	end
end

class GameSounds
	class << self

		attr_reader :jump_sound, :explosion_sound, :option_sound
		attr_reader :select_sound, :shoot_sound, :walking_sound
		attr_reader :orc_ouch, :rubot_ouch, :powerup
		attr_reader :gem_ping, :fireball_bump

		def load(window)
			@shoot_sound = Gosu::Sample.new(window, "media/Sounds/shoot.ogg")
			@jump_sound = Gosu::Sample.new(window, "media/Sounds/jump.ogg")
			@explosion_sound = Gosu::Sample.new(window, "media/Sounds/explosion.ogg")
			@option_sound = Gosu::Sample.new(window, "media/Sounds/option.ogg")
			@select_sound = Gosu::Sample.new(window, "media/Sounds/select.ogg")
			@walking_sound = Gosu::Sample.new(window, "media/Sounds/walking.ogg")
			@orc_ouch = Gosu::Sample.new(window, "media/Sounds/orc-ouch.ogg")
			@rubot_ouch = Gosu::Sample.new(window, "media/Sounds/rubot-ouch.ogg")
			@powerup = Gosu::Sample.new(window, "media/Sounds/powerup.ogg")
			@gem_ping = Gosu::Sample.new(window, "media/Sounds/gem-ping.ogg")
			@fireball_bump = Gosu::Sample.new(window, "media/Sounds/fireball-bump.ogg")
		end
	end
end

class GameMusic
	class << self
		attr_reader :in_game_music, :menu_music

		def load(window)
			@in_game_music = Gosu::Song.new(window, "media/music/in-game-music.ogg")
			@menu_music = Gosu::Song.new(window, "media/music/menu-music.ogg")
		end
	end
end