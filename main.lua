function love.load()
  love.mouse.setVisible(false)
  board = {
    width = 13,
    height = 6 
  } 
  gradient_stops = {
    {{242,0,103},{255, 211, 186}},
    {{243,0,84},{255, 205, 146}},
    {{243,1,62},{255, 203, 91}},
    {{244,0,38},{255, 200, 18}},
    {{244,0,0},{255, 200, 0}},
    {{244,0,0},{255, 199, 0}},
  }
  box_hw = 40
  box_spacing = 5
  x_margin = (love.graphics.getWidth() - (board.width * (box_hw + box_spacing)) / 2)
  y_margin = (love.graphics.getHeight() - (board.height * (box_hw + box_spacing)) / 2)
end

function love.update(dt)
  if love.keyboard.isDown('up') then
    box_spacing = box_spacing - 45 * dt
  end
  if love.keyboard.isDown('down') then
    box_spacing = box_spacing + 45 * dt
  end
end

function love.draw()
  love.graphics.setBackgroundColor(255, 255, 255)
  local color_factor = 1
  for x = 1, board.width, 1 do
   for y = 1, board.height, 1 do

      color_one = gradient_stops[y][2]
      color_two = gradient_stops[y][1]

      if x > 1 then
        color = blendColors(color_one, color_two, color_factor)
        love.graphics.setColor(color[1], color[2], color[3], 255)
      else
        love.graphics.setColor(color_two[1], color_two[2], color_two[3])
      end

      left, top = leftTopCoordsOfBox(x, y)

      love.graphics.rectangle("fill", left-450, top-350, box_hw, box_hw)

      if color_factor > 0 then
        color_factor = color_factor - (.0025 * x)
      end

    end
  end
end

function leftTopCoordsOfBox(x, y)
   local left = x * (box_hw + box_spacing) + x_margin
   local top = y * (box_hw + box_spacing) + y_margin
   return left, top
end

function blendColors(color_one, color_two, factor) 
  local red   = lerp(color_one[1], color_two[1], factor)
  local blue  = lerp(color_one[2], color_two[2], factor)
  local green = lerp(color_one[3], color_two[3], factor)

  return {math.floor(red), math.floor(blue), math.floor(green)}
end

function lerp(value_one, value_two, factor)
  return value_one + (value_two - value_one) * factor
end
