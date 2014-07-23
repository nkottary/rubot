class Collider
	def initialize(list1, list2)
		@list1 = list1
		@list2 = list2
	end

	def update
		@list1.each do |obj1|
			@list2.each do |obj2|
				off_x, off_y = obj1.getCollideOffset obj2
				
					#p "#{off_x} #{off_y}"
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