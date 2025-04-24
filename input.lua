local Input = { left = false, right = false, up = false, down = false }

function Input.update()
  Input.left  = love.keyboard.isDown("a", "left")
  Input.right = love.keyboard.isDown("d", "right")
  Input.up    = love.keyboard.isDown("w", "up")
  Input.down  = love.keyboard.isDown("s", "down")
end

return Input
