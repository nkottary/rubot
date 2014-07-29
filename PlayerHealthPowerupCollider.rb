require_relative 'Collider'

class PlayerHealthPowerupCollider < Collider
	class << self
		def initialize
			super [PlayerHandler::playerObj], HealthPowerupHandler::healthPowerupList
		end

		def action(obj1, obj2, offset_x, offset_y)
			HealthPowerupHandler::healthPowerupList.delete(obj2)
			PlayerHandler::playerObj.heal 50
			GameSounds::powerup.play
		end
	end
end
