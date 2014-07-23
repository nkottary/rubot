require_relative 'Collider'

class PlayerDiamondCollider < Collider
	def initialize(player)
		super [player], Diamond::getDiamondList
	end

	def action(obj1, obj2, offset_x, offset_y)
		Diamond::getDiamondList.delete(obj2)
		obj1.score += 1
	end
end