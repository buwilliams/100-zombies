require 'gosu'
require_relative './base_object.rb'

class Image < BaseObject
  def initialize(properties)
    super({}.merge(properties))
    @scale_x = properties[:scale_x] || 1.0
    @scale_y = properties[:scale_y] || 1.0
    @z = properties[:z] || 0
    @image = Gosu::Image.new(properties[:source])
  end

  def draw
    @image.draw(@x, @y, @z, @scale_x, @scale_y)
    draw_border
  end
end
