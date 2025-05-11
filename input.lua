local Input = {
  move = { left = false, right = false, up = false, down = false },
  shoot = { left = false, right = false, up = false, down = false },
  mouse = { x = 0, y = 0, click = false },
}

function Input.update()
  Input.move.left              = love.keyboard.isDown("a")
  Input.move.right             = love.keyboard.isDown("d")
  Input.move.up                = love.keyboard.isDown("w")
  Input.move.down              = love.keyboard.isDown("s")

  Input.shoot.left             = love.keyboard.isDown("left")
  Input.shoot.right            = love.keyboard.isDown("right")
  Input.shoot.up               = love.keyboard.isDown("up")
  Input.shoot.down             = love.keyboard.isDown("down")

  Input.mouse.x, Input.mouse.y = love.mouse.getPosition()
  Input.mouse.click            = love.mouse.isDown(1)
end

return Input
