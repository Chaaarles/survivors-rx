local DrawSystem = Tiny.sortedProcessingSystem({ isDrawingSystem = true })
DrawSystem.filter = Tiny.requireAll('draw', 'pos')

function DrawSystem:compare(a, b)
  return a.pos.y < b.pos.y
end

function DrawSystem:process(entity, dt)
  entity:draw()
end

return DrawSystem
