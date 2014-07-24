class Collidable

	attr_reader :x, :y, :width, :height, :dir

	def initialize(x, y, width, height, map, dir)
		@x = x
		@y = y
		@width = width
		@height = height
		@map = map
		@dir = dir
		@cur_image = nil
	end

	def brickTouchUp?(newx, newy)

   		@map.solid?(newx - @width / 2, newy - @height / 2) \
   				or 
   			@map.solid?(newx + @width / 2, newy - @height / 2)
  	end

	def brickTouchDown?(newx, newy)

		@map.solid?(newx - @width / 2, newy) \
				or 
			@map.solid?(newx + @width / 2, newy)
	end

	def brickTouchLeft?(newx, newy)

		@map.solid?(newx - @width / 2, newy) \
				or 
			@map.solid?(newx - @width / 2, newy + @height)
	end

	def brickTouchRight?(newx, newy)

		@map.solid?(newx + @width / 2, newy) \
				or 
			@map.solid?(newx + @width / 2, newy + @height)
	end

	# define the line touch methods.
	[["Up", 0, -1], ["Down", 0, 1], ["Left", -1, 0], ["Right", 1, 0]].each do |dir, off_x, off_y|
		define_method("lineTouch#{dir}?") do |dist|

			chk_func = method("brickTouch#{dir}?")
			dist.times do
				if chk_func.call(@x + off_x, @y + off_y) 
					return true 
				else 
					@x += off_x
					@y += off_y  
				end
			end
			false

		end
	end  

	def draw
	    # Flip vertically when facing to the left.
	    if @dir == :left then
	     	offs_x = @width / 2
	     	factor = -1.0
	    else
	     	offs_x = -@width / 2
	     	factor = 1.0
	    end

	    x = @x + offs_x
	    y = @y - @height + 1

	    if @cur_image then @cur_image.draw(x, y, ZOrder::Creature, factor, 1.0) end
  	end

  	def getCollideOffset(obj)
		off_x, off_y = 0, 0

		if @x + @width > obj.x and @y + @height > obj.y and @x < obj.x + obj.width and @y < obj.y + obj.height then

			if @y < obj.y then
				off_y = @y + @height - obj.y
			else 
				off_y = @y - obj.y - obj.height
			end

			if @x < obj.x then
				off_x = @x + @width - obj.x
			else 
				off_x = @x - obj.x - obj.width
			end
		end

		return off_x, off_y
  	end
end