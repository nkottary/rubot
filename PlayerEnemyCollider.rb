require_relative "Collider"

class PlayerEnemyCollider < Collider
	class << self
		def initialize
			super [PlayerHandler::playerObj], BotHandler::botList
		end

		def action(obj1, obj2, offset_x, offset_y)
			PlayerHandler::playerObj.damage(10)
		end
	end
end