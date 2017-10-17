$DEBUG = true

class BaseObject
  TOP_LEFT  = 1
  TOP_RIGHT = 2
  BOT_RIGHT = 3
  BOT_LEFT  = 4

  def initialize(properties)
    @x = properties[:x] || 0
    @y = properties[:y] || 0
    @width = properties[:width] || 64
    @height = properties[:height] || 64
    @window_width = properties[:window_width]
    @window_height = properties[:window_height]
  end

  def update
  end

  def draw
  end

  def collide?(sprite)
    return true if touch?(TOP_LEFT, sprite.corner(BOT_RIGHT))
    return true if touch?(TOP_RIGHT, sprite.corner(BOT_LEFT))
    return true if touch?(BOT_RIGHT, sprite.corner(TOP_LEFT))
    return true if touch?(BOT_LEFT, sprite.corner(TOP_RIGHT))
    return false
  end

  def touch?(position, cornerB)
    cornerA = corner(position)

    if position == TOP_LEFT
      return true if cornerA[:x] <= cornerB[:x] && cornerA[:y] <= cornerB[:y]
    elsif position == TOP_RIGHT
      return true if cornerA[:x] >= cornerB[:x] && cornerA[:y] <= cornerB[:y]
    elsif position == BOT_RIGHT
      return true if cornerA[:x] >= cornerB[:x] && cornerA[:y] >= cornerB[:y]
    elsif position == BOT_LEFT
      return true if cornerA[:x] <= cornerB[:x] && cornerA[:y] >= cornerB[:y]
    end

    return false
  end

  def corner(position)
    if position == TOP_LEFT
      return {x: @x, y: @y}
    elsif position == TOP_RIGHT
      return {x: @x + @width, y: @y}
    elsif position == BOT_RIGHT
      return {x: @x + @width, y: @y + @height}
    elsif position == BOT_LEFT
      return {x: @x, y: @y + @height}
    end
  end

  def draw_border
    return unless $DEBUG
    Gosu::draw_line(@x, @y, @color, @x + @width, @y, @color)
    Gosu::draw_line(@x + @width, @y, @color, @x + @width, @y + @height, @color)
    Gosu::draw_line(@x + @width, @y + @width, @color,
                    @x, @y + @height, @color)
    Gosu::draw_line(@x, @y + @height, @color,
                    @x, @y, @color)
  end

  def align_top
    @y = 0
  end

  def align_bottom
    @y = @window_height - @height
  end

  def align_left
    @x = 0
  end

  def align_right
    @x = @window_width - @width
  end
end
