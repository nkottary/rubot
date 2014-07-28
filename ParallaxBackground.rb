#draw a parallax background i.e move the background image as player moves.
class ParallaxBackground
    class << self
        def initialize
            #pixel ratio of image to window.
            map_width = (Map::width + 15) * 50
            map_height = (Map::height + 10) * 50
            @w_ratio = Float(GameImages::gameBackground.width) / map_width
            @h_ratio = Float(GameImages::gameBackground.height) / map_height

            @x, @y = 0, 0
        end

        def draw
            GameImages::gameBackground.draw(@x, @y, ZOrder::Background) 
        end

        def update
            @x = -ScrollingCamera::camera_x * @w_ratio
            @y = -ScrollingCamera::camera_y * @h_ratio
        end
    end
end