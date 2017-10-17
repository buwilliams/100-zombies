require 'gosu'
require_relative './brave_girl.rb'
require_relative './image.rb'

class LevelOne
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

    @items << tile1
    @items << tile2
  end

  def update
    current_x = @brave_girl.x
    current_y = @brave_girl.y

    @brave_girl.update
    @items.each do |image|
      image.update
      if @brave_girl.collide? image
        @brave_girl.x = current_x
        @brave_girl.y = current_y
      end
    end
  end

  def draw
    @brave_girl.draw
    @items.each { |i| i.draw }
  end
end
