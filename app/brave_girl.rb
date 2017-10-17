require 'gosu'
require_relative './base_object.rb'

class BraveGirl < BaseObject
  def initialize(properties)
    super({ x: 0, y: 0, width: 52, height: 52 }.merge(properties))

    @speed = 5
    @frame_count = 0

    @direction = Gosu::KB_RIGHT
    @running = false
    @jumping = false

    @idle_frame_change = 10
    @idle_pointer = 0
    @idle = [
      Gosu::Image.new("app/assets/adventure_girl/Idle (1).png"),
      Gosu::Image.new("app/assets/adventure_girl/Idle (2).png"),
      Gosu::Image.new("app/assets/adventure_girl/Idle (3).png"),
      Gosu::Image.new("app/assets/adventure_girl/Idle (4).png"),
      Gosu::Image.new("app/assets/adventure_girl/Idle (5).png"),
      Gosu::Image.new("app/assets/adventure_girl/Idle (6).png"),
      Gosu::Image.new("app/assets/adventure_girl/Idle (7).png"),
      Gosu::Image.new("app/assets/adventure_girl/Idle (8).png"),
      Gosu::Image.new("app/assets/adventure_girl/Idle (9).png"),
      Gosu::Image.new("app/assets/adventure_girl/Idle (10).png")
    ]

    @run_frame_change = 2
    @run_pointer = 0
    @run = [
      Gosu::Image.new("app/assets/adventure_girl/Run (1).png"),
      Gosu::Image.new("app/assets/adventure_girl/Run (2).png"),
      Gosu::Image.new("app/assets/adventure_girl/Run (3).png"),
      Gosu::Image.new("app/assets/adventure_girl/Run (4).png"),
      Gosu::Image.new("app/assets/adventure_girl/Run (5).png"),
      Gosu::Image.new("app/assets/adventure_girl/Run (6).png"),
      Gosu::Image.new("app/assets/adventure_girl/Run (7).png"),
      Gosu::Image.new("app/assets/adventure_girl/Run (8).png")
    ]

    @fall = Gosu::Image.new("app/assets/adventure_girl/Jump (5).png")
  end

  def update
    # update frame count
    @frame_count += 1
    button_pressed = false

    if Gosu::button_down?(Gosu::KB_W)
      @y -= @speed #@height # up
      @frame_count = 0 if !@running
      @running = false
      @jumping = true
      button_pressed = true
    elsif Gosu::button_down?(Gosu::KB_S)
      @y += @speed #@height # down
      @frame_count = 0 if !@running
      @running = false
      @jumping = true
      button_pressed = true
    end

    if Gosu::button_down?(Gosu::KB_A)
      @x -= @speed #@width # left
      @frame_count = 0 if !@running
      @direction = Gosu::KB_LEFT
      @running = true
      @jumping = false
      button_pressed = true
    elsif Gosu::button_down?(Gosu::KB_D)
      @x += @speed #@width # right
      @frame_count = 0 if !@running
      @direction = Gosu::KB_RIGHT
      @running = true
      @jumping = false
      button_pressed = true
    end

    unless button_pressed
      @running = false
      @jumping = false
    end

    # constrain to window
    @y = 0 if @y < 0
    @y = @window_height - @height if (@height + @y) > @window_height
    @x = 0 if @x < 0
    @x = @window_width - @width if (@width + @x) > @window_width

    if @running
      if @frame_count == @run_frame_change
        @run_pointer += 1
        @run_pointer = 0 if @run_pointer > (@run.size - 1)
        @frame_count = 0
      end
    else
      # setup idle_pointer
      if @frame_count == @idle_frame_change
        @idle_pointer += 1
        @idle_pointer = 0 if @idle_pointer > (@idle.size - 1)
        @frame_count = 0
      end
    end
  end

  def draw
    if @running
      if @direction == Gosu::KB_RIGHT
        @run[@run_pointer].draw(@x, @y, 100, 1.0, 1.0)
      else
        @run[@run_pointer].draw(@x + @width, @y, 100, -1.0, 1.0)
      end
    elsif @jumping
      if @direction == Gosu::KB_RIGHT
        @fall.draw(@x, @y, 100, 1.0, 1.0)
      else
        @fall.draw(@x + @width, @y, 100, -1.0, 1.0)
      end
    else
      if @direction == Gosu::KB_RIGHT
        @idle[@idle_pointer].draw(@x, @y, 100, 1.0, 1.0)
      else
        @idle[@idle_pointer].draw(@x + @width, @y, 100, -1.0, 1.0)
      end
    end

    draw_border
  end
end
