$DEBUG = false

class Sprite
  def draw_border
    return unless $DEBUG
    Gosu::draw_line(@x, @y, @color, @x + @width, @y, @color)
    Gosu::draw_line(@x + @width, @y, @color, @x + @width, @y + @height, @color)
    Gosu::draw_line(@x + @width, @y + @width, @color,
                    @x, @y + @height, @color)
    Gosu::draw_line(@x, @y + @height, @color,
                    @x, @y, @color)
  end
end
