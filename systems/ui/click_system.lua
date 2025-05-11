local ClickSystem  = Tiny.processingSystem()
ClickSystem.filter = Tiny.requireAll('click', 'pos', 'size', 'action')
local input        = require('input')

function ClickSystem:process(entity, dt)
  local mouseX, mouseY, click = input.mouse.x, input.mouse.y, input.mouse.click

  -- Check if the mouse is within the entity's bounds
  if mouseX >= entity.pos.x and mouseX <= entity.pos.x + entity.size.width and
      mouseY >= entity.pos.y and mouseY <= entity.pos.y + entity.size.height and
      click then
    if not entity.click then
      -- Call the action associated with the button
      if entity.action then
        entity.action()
      end
    end
    entity.click = true
  else
    entity.click = false
  end
end

return ClickSystem
