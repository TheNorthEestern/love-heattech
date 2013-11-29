function love.load()
  board = {
    width = 13,
    height = 6 
  } 
  box_hw = 40
  box_spacing = 5
  x_margin = (love.graphics.getWidth() - (board.width * (box_hw + box_spacing)) / 2)
  y_margin = (love.graphics.getHeight() - (board.height * (box_hw + box_spacing)) / 2)
  color_one = {255, 199, 0}
  color_two = {242, 0  , 103}
end

function love.update(dt)
  if love.keyboard.isDown('up') then
    box_spacing = box_spacing + 45 * dt
  end
  if love.keyboard.isDown('down') then
    box_spacing = box_spacing - 45 * dt
  end
end

function love.draw()
  love.graphics.setBackgroundColor(255, 255, 255)
  local color_factor = (board.height*board.width/100)
  local band = board.height*board.width/13
  for x = 1, board.width, 1 do
   for y = 1, board.height, 1 do
      left, top = leftTopCoordsOfBox(x, y)
      if x >= 2 or y >= 2 then
        color = blendColors(color_one, color_two, color_factor)
        love.graphics.setColor(color[1], color[2], color[3], 255)
        if x < board.width then
        end
      else
        love.graphics.setColor(color_two[1], color_two[2], color_two[3])
      end
      love.graphics.rectangle("fill", left-450, top-350, box_hw, box_hw)
      if color_factor > 0 then
        color_factor = color_factor - .009
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
