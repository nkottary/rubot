class Arrow

	X_DIST = 25 # 50 pixels of oscillation

	def initialize(window, offset_x)
		@image = Image.new(window, 'media/arrow.png', true)
		@offset_x = offset_x
	end

	def draw
		@image.draw(@x, @y, ZOrder::UI)
	end

	def set(x, y)
		@start_x = x - @offset_x
		@end_x = @start_x + X_DIST
		@x = @start_x
		@y = y
		@dir = :right
	end

	def update
		if @dir == :right and @x > @end_x
			@dir = :left
		elsif @dir == :left and @x < @start_x
			@dir = :right
		end

		if @dir == :right
			@x = @x + 1
		elsif @dir == :left
			@x = @x - 1
		end 
	end
end