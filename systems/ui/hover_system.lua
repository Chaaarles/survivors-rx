local HoverSystem  = Tiny.processingSystem()
HoverSystem.filter = Tiny.requireAll('hover', 'pos', 'size')
local input        = require('input')

function HoverSystem:process(entity, dt)
  local mouseX, mouseY = input.mouse.x, input.mouse.y

  -- Check if the mouse is within the entity's bounds
  if mouseX >= entity.pos.x and mouseX <= entity.pos.x + entity.size.width and
      mouseY >= entity.pos.y and mouseY <= entity.pos.y + entity.size.height then
    entity.hover = true
  else
    entity.hover = false
  end
end

return HoverSystem
