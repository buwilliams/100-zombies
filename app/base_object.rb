$DEBUG = false

class BaseObject
  attr_accessor :x, :y, :width, :height, :velocity, :acceleration

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
    @color = properties[:color] || Gosu::Color::AQUA
    @velocity = properties[:velocity] || { x: 0, y: 0 }
    @acceleration = properties[:velocity] || { x: 0, y: 0 }
  end

  def update
    @velocity[:x] += @acceleration[:x]
    @velocity[:y] += @acceleration[:y]

    @x += @velocity[:x]
    @y += @velocity[:y]

    # constrain to window
    if @y < 0
      @y = 0
      @velocity[:y] = 0
    elsif (@height + @y) > @window_height
      @y = @window_height - @height
      @velocity[:y] = 0
    end

    if @x < 0
      @x = 0
      @velocity[:x] = 0
    elsif (@width + @x) > @window_width
      @x = @window_width - @width
      @velocity[:x] = 0
    end

    @acceleration[:x] = 0
    @acceleration[:y] = 0
  end

  def draw
    draw_border
  end

  def add_force(x, y)
    @acceleration[:x] += x
    @acceleration[:y] += y
  end

  def reset_velocity
    @velocity = { x: 0, y: 0 }
  end

  def collide?(sprite)
    if @x < sprite.x + sprite.width &&
       @x + @width > sprite.x &&
       @y < sprite.y + sprite.height &&
       @height + @y > sprite.y
      return true
    else
      return false
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

  def align_center
    @x = (@window_width / 2) - (@width / 2)
  end

  def align_middle
    @y = (@window_height / 2) - (@height / 2)
  end
end
