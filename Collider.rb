class Collider
	class << self	
		def initialize(list1, list2)
			@list1 = list1
			@list2 = list2
		end

		def update
			@list1.each do |obj1|
				@list2.each do |obj2|
					off_x, off_y = obj1.getCollideOffset obj2
					
					#p "off = (#{off_x}, #{off_y}), obj1 = (#{obj1.x}, #{obj1.y}), obj2 = (#{obj2.x}, #{obj2.y})"
					if off_x != 0 or off_y != 0
						action(obj1, obj2, off_x, off_y) 
					end
				end
			end
		end

		def action(obj1, obj2, offset_x, offset_y)
			raise NotImplementedError
		end
	end
end