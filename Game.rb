class Game

	def initialize(window)
        @window = window
		@map = Map.new(window, "media/CptnRuby Map.txt")
		@parallax_bg = ParallaxBackground.new(window, "media/sky_bg.png", (@map.width + 15) * 50, (@map.height + 10) * 50)
		@player = Player.new(window, @map, 400, 100)

		 # The scrolling position is stored as top left corner of the screen.
    	@camera_x = @camera_y = 0

    	@pauseHandler = PauseHandler.new(window)
    	@bot = NoFallBot.new(window, @map, 400, 100)
    	Fireball::init window, @map
    	Diamond::init window
    	@playerDiamondCollider = PlayerDiamondCollider.new @player
    	@gameState = :playing
    	@gameQuit = false
	end

	def draw
		@parallax_bg.draw
        @window.translate(-@camera_x, -@camera_y) do
          	@map.draw
          	@player.draw
          	@bot.draw
          	Fireball::draw
          	Diamond::draw
        end
        Fonts::smallFont.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff990000)
        @pauseHandler.draw if @gameState == :paused
	end

	def update
		if @gameState == :playing then
	        @bot.update
	        @player.update
	        @playerDiamondCollider.update

	        # Scrolling follows player
	        @camera_x = [[@player.x - 320, 0].max, @map.width * 50 - 640].min
	        @camera_y = [[@player.y - 240, 0].max, @map.height * 50 - 480].min

	        @parallax_bg.update @camera_x, @camera_y
	        Fireball::update
	        Diamond::update
	    elsif @gameState == :paused then
	        @pauseHandler.update
	    end
	end

	def button_up(id)
        if @gameState == :playing then
            if id == KbLeft or id == KbRight then
                @player.stop
            elsif id == KbUp then
                @player.stop_jump
            end
        end
    end

    def button_down(id)
    	if @gameState == :paused 
            if id == KbEscape then @gameState = :playing
            elsif id == KbRight or id == KbLeft then @pauseHandler.toggle
            elsif id == KbReturn then doPauseAction 
            end
        elsif @gameState == :playing
	    	if id == KbEscape then @gameState = :paused
	        elsif id == KbRight then @player.move_right
	        elsif id == KbLeft then @player.move_left
	        elsif id == KbUp then @player.jump 
	        elsif id == KbSpace then Fireball::spawn @player.x, @player.y, @player.dir
	        end
	    end
    end

    def doPauseAction
        option = @pauseHandler.getSelection
        if option == :yes
        	@gameQuit = true
        elsif option == :no 
        	@gameState = :playing 
        end
    end

    def userQuit?
    	@gameQuit
    end
end