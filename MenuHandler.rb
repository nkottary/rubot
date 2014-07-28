require_relative "Menu"

class MenuHandler
	class << self
		def initialize(onStartGame, onQuit)

			menuActions = { mainMenu: [:startGame, :enterHighScores, :enterControls, :quit],
							highScore: [nil, nil, :backToMainMenu],
							controls: [nil, nil, nil, nil, :backToMainMenu]}

			menuActions.each do |key, value|
				value.map! do |action|
					if action == nil
						nil
					else 
						method(action)
					end
				end
			end

			@mainMenu = Menu.new("Main Menu", ["Start Game", "High Score", "Controls", "Quit"],
											menuActions[:mainMenu])
			@highScoreMenu = Menu.new("High Score", ["Nisanth: 3000", "Pratheek: 300", "Back"],
											menuActions[:highScore])
			@controlsMenu = Menu.new("Controls", ["Move left: left", "Move right: right", "Jump: up", "Fireball: ctrl", "Back"],
											menuActions[:controls])
			@currentMenu = @mainMenu

			@onStartGame = onStartGame
			@onQuit = onQuit
		end

		def draw
			@currentMenu.draw
		end

		def update
			@currentMenu.update
		end

	    def button_down(key)
	        case key
	        when Gosu::KbUp
	            @currentMenu.previousOption
	        when Gosu::KbDown
	            @currentMenu.nextOption
	        when Gosu::KbReturn
	            @currentMenu.doAction
	        when Gosu::KbEscape
	            @currentMenu.goBack
	        end
	    end

		private

		def backToMainMenu
			@currentMenu = @mainMenu
		end

		def enterHighScores
			@currentMenu = @highScoreMenu
		end

		def enterControls
			@currentMenu = @controlsMenu
		end

		def startGame
			@onStartGame.call
		end

		def quit
			@onQuit.call
		end
	end
end