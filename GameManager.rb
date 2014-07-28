require_relative "Game"
require_relative "PauseHandler"
require_relative "EndGameHandler"

class GameManager
	class << self

		attr_reader :currentLevel

		def initialize(onQuit)
			@levelMaps = []

			NUM_OF_LEVELS.times do |i|
				@levelMaps << "media/level#{i + 1}.txt"
			end

	        @currentLevel = 0
	        @gameState = :playing
	        @onQuit = onQuit

	        PauseHandler::initialize method(:quit), method(:resumeGame)
	        EndGameHandler::initialize method(:nextLevel)
		end

		def startNewGame
	        @currentLevel = 0
	        startLevel
	    end

		def draw
			case @gameState
				when :playing
					Game::draw
				when :paused
					Game::draw
					PauseHandler::draw
				when :endGame
					EndGameHandler::draw
			end
		end

		def update
			case @gameState
				when :playing
					Game::update
					if Game::isWon?
	           		 	@gameState = :endGame
	        		end
				when :paused
					PauseHandler::update
				when :endGame
					EndGameHandler::update
			end
		end

		def button_down(id)
			case @gameState
				when :playing
					if id == Gosu::KbEscape
						pauseGame
					else
						Game::button_down id
					end
				when :paused
					PauseHandler::button_down id
				when :endGame
					EndGameHandler::button_down id
			end
		end

		def button_up(id)
			if @gameState == :playing
				Game::button_up id
			end
		end

		private
		
		def quit
			@onQuit.call
		end

		
		def pauseGame
			@gameState = :paused
		end

		
		def resumeGame
			@gameState = :playing
		end

		def nextLevel
			if @currentLevel < NUM_OF_LEVELS - 1
				@currentLevel += 1 
				startLevel
			else
				quit
			end
		end

		def startLevel
	    	Game::initialize @levelMaps[@currentLevel]
	    	@gameState = :playing
	    end
	end
end