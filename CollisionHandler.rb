require_relative "PlayerDiamondCollider"
require_relative "PlayerEnemyCollider"
require_relative "FireballEnemyCollider"
require_relative "PlayerHealthPowerupCollider"

class CollisionHandler
	class << self
		def initialize
            PlayerDiamondCollider::initialize
            PlayerEnemyCollider::initialize
            FireballEnemyCollider::initialize
            PlayerHealthPowerupCollider::initialize
		end

		def update
			PlayerDiamondCollider::update
            PlayerEnemyCollider::update
            FireballEnemyCollider::update
            PlayerHealthPowerupCollider::update
		end
	end
end
