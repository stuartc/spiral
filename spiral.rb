#!/usr/bin/env ruby -wKU

class Integer
  def is_perfect_square?
    Math.sqrt(self).remainder(1) == 0
  end
end

class Spiral

  def initialize(number)
    @number = number
    @width = Math.sqrt(number).to_i
    go
  end

  def go
    # create an array with placeholders
    a = @width.times.collect { @width.times.to_a.collect { nil } } 
    # start at the top left
    x,y = 1,1
    direction = nil
    n = @number
    while n > 0 do
      direction = next_direction(direction)
      while true
        #puts "direction: #{direction.to_s.each_char.first}\tcoords: #{x},#{y}\tn: #{n}"
        a[y-1][x-1] = n
        ox,oy = x,y
        x,y = *move(x,y,direction)
        n -= 1

        # hit a corner change direction
        if x <= 0 || x >= @width + 1 || y <= 0 || y >= @width + 1
          x,y = *move(ox,oy,next_direction(direction))
          break
        end

        # is the cell occupied?
        if !a[y-1][x-1].nil? 
          x,y = *move(ox,oy,next_direction(direction))
          break
        end
      end
    end

    print_array a
  end

  private

  def move(x,y,direction)
    x += 1 if direction == :right
    y -= 1 if direction == :up
    x -= 1 if direction == :left
    y += 1 if direction == :down
    [x,y]
  end

  def next_direction(current_direction=nil)
    movements = [:right, :down, :left, :up]
    if current_direction.nil?
      movement_index = 0
    else
      movement_index = movements.index(current_direction) + 1
      movement_index = 0 if movements.index(current_direction) == 3
    end
    movements[movement_index]
  end

  def print_array(array)
    array.each do |y|
      puts y.collect {|x| x.to_s.rjust(@number.to_s.length)}.join(' ')
    end
  end

end

raise ArgumentError, "Please input a perfect square" unless ARGV[0].to_i.is_perfect_square?
Spiral.new(ARGV[0].to_i)
