def getCollideOffset(obj)
	off_x, off_y = 0, 0

	x1 = @x - @width / 2
	y1 = @y - @height / 2

	x2 = obj.x - obj.width / 2
	y2 = obj.y - obj.height / 2

	if x1 + @width > x2 and y1 + @height > y2 and x1 < x2 + obj.width and y1 < y2 + obj.height then
		echo "dude"

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