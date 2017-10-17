require 'gosu'
require_relative './level_one.rb'

class World < Gosu::Window
  GRAVITY = 2.4

  def initialize
    super(1250, 700)

    @level = LevelOne.new(self.width, self.height)
    #@brave_girl = BraveGirl.new(self.width, self.height)
    @background = Gosu::Image.new("app/assets/graveyard/bg.png")
  end

  def update
    # handle events
    self.close! if Gosu::button_down?(Gosu::KB_ESCAPE)

    @level.update

    # update state
    #@brave_girl.update
  end

  def draw
    # draw white screen
    color = Gosu::Color::WHITE
    Gosu.draw_rect(0, 0, self.width, self.height, color)

    # draw background
    @background.draw(0, 0, 0, 1.0, 1.0)

    @level.draw

    # draw brave girl
    # @brave_girl.draw
  end
end

World.new.show
