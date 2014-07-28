class ScrollingCamera
	class << self
		attr_reader :camera_x, :camera_y

		def initialize
			@camera_x = @camera_y = 0
		end

		def update
			@camera_x = [[PlayerHandler::playerObj.x - 320, 0].max, Map::width * 50 - 640].min
		    @camera_y = [[PlayerHandler::playerObj.y - 240, 0].max, Map::height * 50 - 480].min
		end

		def translateAndDraw(&block)
			MainGameHandler::window.translate(-@camera_x, -@camera_y) do
				block.call
			end
		end
	end
end