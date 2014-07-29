class HealthPowerupHandler
    class << self
        attr_reader :healthPowerupList

        def initialize
            @healthPowerupList = []
        end

        def spawn(x, y)
            @healthPowerupList << HealthPowerup.new(x, y)
        end

        def update
            @healthPowerupList.each do |healthPowerup|
                healthPowerup.update
            end
        end

        def draw
            @healthPowerupList.each do |healthPowerup|
                healthPowerup.draw
            end
        end
    end

    private
    class HealthPowerup < Collidable
        def initialize(x, y)
            super x, y, 50, 50, nil
            @size = 0
        end

        def update
            @size = 0.75 + Math.sin(Gosu::milliseconds / 133.7) / 4
        end

        def draw
            # Draw, slowly rotating
            MainGameHandler::window.scale(@size, @size, @x, @y) do
                GameImages::healthPowerupImage.draw(@x - 25, @y - 25, ZOrder::UI)
            end
        end
    end
end