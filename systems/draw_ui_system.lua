local DrawUiSystem = Tiny.processingSystem({ isDrawingSystem = true })
DrawUiSystem.filter = Tiny.requireAll('draw', 'userInterface')

function DrawUiSystem:process(entity, dt)
  entity:draw()
end

return DrawUiSystem
