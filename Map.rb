require_relative 'helpers'
require_relative 'Diamond'

# Map class holds and draws tiles and gems.
class Map
  attr_reader :width, :height, :gems

  def self.init(window)
    @@tileset = Image.load_tiles(window, "media/CptnRuby Tileset.png", 60, 60, true)
  end


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
          Diamond::spawn xpos, ypos
          nil
        when 'p'
          Player::position xpos, ypos
          nil
        when 'b'
          Bot::spawn xpos, ypos
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
        if tile
          # Draw the tile with an offset (tile images have some overlap)
          # Scrolling is implemented here just as in the game objects.
          @@tileset[tile].draw(x * 50 - 5, y * 50 - 5, ZOrder::Map)
        end
      end
    end
  end
  
  # Solid at a given pixel position?
  def solid?(x, y)
    y < 0 || @tiles[x / 50][y / 50]
  end
end