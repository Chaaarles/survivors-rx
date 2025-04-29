local DrawSystem = Tiny.processingSystem({ isDrawingSystem = true })
DrawSystem.filter = Tiny.requireAll('draw')

function DrawSystem:process(entity, dt)
  entity:draw()
end

return DrawSystem
