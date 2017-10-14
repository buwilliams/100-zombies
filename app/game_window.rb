require 'gosu'
require_relative './brave_girl.rb'

class GameWindow < Gosu::Window
  def initialize
    super(1000, 700)

    @brave_girl = BraveGirl.new(self.width, self.height)
  end

  def update
    # handle events
    self.close! if Gosu::button_down?(Gosu::KB_ESCAPE)

    # update state
    @brave_girl.update
  end

  def draw
    # draw white screen
    color = Gosu::Color::WHITE
    Gosu.draw_rect(0, 0, self.width, self.height, color)

    @brave_girl.draw
  end
end

GameWindow.new.show
