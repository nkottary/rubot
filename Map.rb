# Map class holds and draws tiles and gems.
class Map
    class << self
        attr_reader :width, :height

        def initialize(filename)
            # Load 60x60 tiles, 5px overlap in all four directions.
            lines = File.readlines(filename).map { |line| line.chomp }
            @height = lines.size
            @width = lines[0].size
            @tiles = Array.new(@width) do |x|
                xpos = x * 50 + 25
                Array.new(@height) do |y|
                    ypos = y * 50 + 25
                    case lines[y][x, 1]
                    when '"'
                        Tiles::Grass
                    when '#'
                        Tiles::Earth
                    when 'x'
                        DiamondHandler::spawn xpos, ypos
                        nil
                    when 'p'
                        PlayerHandler::initialize xpos, ypos
                        nil
                    when 'b'
                        BotHandler::spawn xpos, ypos
                        nil
                    end
                end
            end
        end
        
        def draw
            # Very primitive drawing function:
            # Draws all the tiles, some off-screen, some on-screen.
            @height.times do |y|
                @width.times do |x|
                    tile = @tiles[x][y]
                    x1 = x * 50
                    y1 = y * 50
                    if tile and inScreen? x1, y1
                        # Draw the tile with an offset (tile images have some overlap)
                        # Scrolling is implemented here just as in the game objects.
                        GameImages::tileset[tile].draw(x1 - 5, y1 - 5, ZOrder::Map)
                    end
                end
            end
        end
        
        # Solid at a given pixel position?
        def solid?(x, y)
            y < 0 || @tiles[x / 50][y / 50]
        end

        private
        def inScreen?(x1, y1)
            off_x, off_y = 0, 0

            x2 = ScrollingCamera::camera_x
            y2 = ScrollingCamera::camera_y

            if x1 + 50 > x2 and y1 + 50 > y2 and x1 < x2 + 640 and y1 < y2 + 480 then

                off_x = if x1 < x2 then
                            x1 + 50 - x2
                        else 
                            x1 - x2 - 640
                        end
                        
                off_y = if y1 < y2 then
                            y1 + 50 - y2
                        else 
                            y1 - y2 - 480
                        end
            end

           (off_x != 0 or off_y != 0)
        end

    end
end