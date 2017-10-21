require 'gosu'
require_relative './brave_girl.rb'
require_relative './image.rb'

class LevelOne
  GRAVITY = 1.4

  def initialize(window_width, window_height)
    @window_width = window_width
    @window_height = window_height
    @items = []

    @brave_girl = BraveGirl.new(window_width: @window_width,
                                window_height: @window_height)

    tile1 = Image.new(window_width: @window_width,
                      window_height: @window_height,
                      source: 'app/assets/graveyard/tiles/Tile (1).png',
                      width: 128,
                      height: 128)
    tile1.align_bottom
    tile1.align_left

    tile2 = Image.new(window_width: @window_width,
                      window_height: @window_height,
                      source: 'app/assets/graveyard/tiles/Tile (3).png',
                      x: 100,
                      width: 128,
                      height: 128)
    tile2.align_bottom

    tile3 = Image.new(window_width: @window_width,
                      window_height: @window_height,
                      source: 'app/assets/graveyard/tiles/Tile (1).png',
                      width: 128,
                      height: 128)
    tile3.align_bottom
    tile3.align_right
    tile3.x -= 100

    tile4 = Image.new(window_width: @window_width,
                      window_height: @window_height,
                      source: 'app/assets/graveyard/tiles/Tile (3).png',
                      x: 100,
                      width: 128,
                      height: 128)
    tile4.align_bottom
    tile4.align_right

    tile5 = Image.new(window_width: @window_width,
                      window_height: @window_height,
                      source: 'app/assets/graveyard/tiles/Tile (1).png',
                      width: 128,
                      height: 128)
    tile5.align_center
    tile5.align_middle
    tile5.x += 100
    tile5.y -= 100

    tile6 = Image.new(window_width: @window_width,
                      window_height: @window_height,
                      source: 'app/assets/graveyard/tiles/Tile (3).png',
                      x: 100,
                      width: 128,
                      height: 128)
    tile6.align_center
    tile6.align_middle
    tile6.x += 200
    tile6.y -= 100

    @items << tile1
    @items << tile2
    @items << tile3
    @items << tile4
    @items << tile5
    @items << tile6
  end

  def update
    current_x = @brave_girl.x
    current_y = @brave_girl.y

    # apply gravity to brave girl
    @brave_girl.add_force(0, GRAVITY)
    if @brave_girl.velocity[:x] > 0.4
      @brave_girl.add_force(-0.2, 0) # friction
    elsif @brave_girl.velocity[:x] < -0.4
      @brave_girl.add_force(0.2, 0) # friction
    else
      @brave_girl.velocity[:x] = 0
    end
    @brave_girl.update

    @items.each do |image|
      if @brave_girl.collide? image
        @brave_girl.y = current_y
        @brave_girl.velocity[:y] = 0
      end
    end

    @items.each do |image|
      image.update
      if @brave_girl.collide? image
        @brave_girl.x = current_x
        @brave_girl.y = current_y
        @brave_girl.reset_velocity
      end
    end
  end

  def draw
    @brave_girl.draw
    @items.each { |i| i.draw }
  end
end
