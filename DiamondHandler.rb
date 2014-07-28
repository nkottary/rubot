class DiamondHandler
    class << self
        attr_reader :diamondList

        def initialize
            @diamondList = []
        end

        def spawn(x, y)
            @diamondList << Diamond.new(x, y)
        end

        def update
          @diamondList.each do |diamond|
            diamond.update
          end
        end

        def draw
          @diamondList.each do |diamond|
            diamond.draw
          end
        end

        def allGemsCollected?
          @diamondList.empty?
        end
    end

    private
    class Diamond < Collidable
        def initialize(x, y)
            super x, y, 50, 50, nil
            @angle = 0
        end

        def update
            @angle = 25 * Math.sin(Gosu::milliseconds / 133.7)
        end

        def draw
          # Draw, slowly rotating
            GameImages::diamondImage.draw_rot(@x, @y, ZOrder::Diamond, @angle)
        end
    end
end