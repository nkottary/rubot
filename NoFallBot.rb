require_relative 'helpers'

#bot wont fall off edges.
class NoFallBot < Bot
  def update
    super
    if @vy == 0 and not @map.solid?(@x, @y + 1) then
      reverse
    end
  end
end