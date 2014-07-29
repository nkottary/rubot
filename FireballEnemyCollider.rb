require_relative 'Collider'

class FireballEnemyCollider < Collider
	class << self
		def initialize
			super FireballHandler::fireballList, BotHandler::botList
		end

		def action(obj1, obj2, offset_x, offset_y)
			FireballHandler::fireballList.delete(obj1)
			obj2.damage 1
		end
	end
end
