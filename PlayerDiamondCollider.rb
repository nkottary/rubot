require_relative 'Collider'

class PlayerDiamondCollider < Collider
	class << self
		def initialize
			super [PlayerHandler::playerObj], DiamondHandler::diamondList
		end

		def action(obj1, obj2, offset_x, offset_y)
			DiamondHandler::diamondList.delete(obj2)
			ScoreBoard::increment
			GameSounds::gem_ping.play
		end
	end
end
