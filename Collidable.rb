class Collidable

	attr_reader :x, :y, :width, :height, :dir

	def initialize(x, y, width, height, dir)
		@x = x
		@y = y
		@width = width
		@height = height
		@dir = dir
		@cur_image = nil
	end

	def broadTouchUp?(newx, newy)

   		Map::solid?(newx - @width / 2, newy - @height / 2) \
   				or 
   			Map::solid?(newx + @width / 2, newy - @height / 2) \
   					or
   				narrowTouchUp?(newx, newy)
  	end

	def broadTouchDown?(newx, newy)

		Map::solid?(newx - @width / 2, newy + @height / 2) \
				or 
			Map::solid?(newx + @width / 2, newy + @height / 2) \
					or
   				narrowTouchDown?(newx, newy)
	end

	def broadTouchLeft?(newx, newy)

		Map::solid?(newx - @width / 2, newy - @height / 2) \
				or 
			Map::solid?(newx - @width / 2, newy + @height / 2) \
					or
   				narrowTouchLeft?(newx, newy)
	end

	def broadTouchRight?(newx, newy)

		Map::solid?(newx + @width / 2, newy - @height / 2) \
				or 
			Map::solid?(newx + @width / 2, newy + @height / 2) \
					or
   				narrowTouchRight?(newx, newy)
	end

	# define the broad line touch methods.
	[["Up", 0, -1], ["Down", 0, 1], ["Left", -1, 0], ["Right", 1, 0]].each do |dir, off_x, off_y|
		define_method("broadLineTouch#{dir}?") do |dist|

			chk_func = method("broadTouch#{dir}?")
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

	def narrowTouchUp?(newx, newy)
   		Map::solid?(newx, newy - @height / 2) 
  	end

	def narrowTouchDown?(newx, newy)
		Map::solid?(newx, newy + @height / 2) 
	end

	def narrowTouchLeft?(newx, newy)
		Map::solid?(newx - @width / 2, newy) 
	end

	def narrowTouchRight?(newx, newy)
		Map::solid?(newx + @width / 2, newy)
	end

	# define the narrow line touch methods.
	[["Up", 0, -1], ["Down", 0, 1], ["Left", -1, 0], ["Right", 1, 0]].each do |dir, off_x, off_y|
		define_method("narrowLineTouch#{dir}?") do |dist|

			chk_func = method("narrowTouch#{dir}?")
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

    def leftRightMove(vel)
        (@dir == :right and narrowLineTouchRight? vel) \
        		or
        	(@dir == :left and narrowLineTouchLeft? vel)
    end

	def draw
	    # Flip vertically when facing to the left.
	    return if not @cur_image

	    if @dir == :left then
	     	offs_x = @width / 2
	     	factor = -1.0
	    else
	     	offs_x = -@width / 2
	     	factor = 1.0
	    end

	    x = @x + offs_x
	    y = @y - @height + 1

	    @cur_image.draw(x, y, ZOrder::Creature, factor, 1.0)
  	end

  	def getCollideOffset(obj)
		off_x, off_y = 0, 0

		x1 = @x - @width / 2
		y1 = @y - @height / 2

		x2 = obj.x - obj.width / 2
		y2 = obj.y - obj.height / 2

		if x1 + @width > x2 and y1 + @height > y2 and x1 < x2 + obj.width and y1 < y2 + obj.height then

			off_x = if x1 < x2 then
						x1 + @width - x2
					else 
						x1 - x2 - obj.width
					end
					
			off_y = if y1 < y2 then
						y1 + @height - y2
					else 
						y1 - y2 - obj.height
					end
		end

		return off_x, off_y
  	end
end