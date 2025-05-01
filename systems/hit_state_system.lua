local HitStateSystem = Tiny.processingSystem()
HitStateSystem.filter = Tiny.requireAll("hitState")

function HitStateSystem:process(entity, dt)
  if entity.hitState > 0 then
    entity.hitState = entity.hitState - dt
    if entity.hitState <= 0 then
      entity.hitState = 0
    end
  end
end

return HitStateSystem
