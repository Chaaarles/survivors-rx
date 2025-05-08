local StunSystem = Tiny.processingSystem()
StunSystem.filter = Tiny.requireAll("stun")

function StunSystem:process(entity, dt)
  if entity.stun.value > 0 then
    entity.stun.value = entity.stun.value - dt
    if entity.stun.value <= 0 then
      entity.stun.value = 0
    end
  end
end

return StunSystem
