local DifficultySystem = Tiny.processingSystem()
DifficultySystem.filter = Tiny.requireAll('enemySpawner')

function DifficultySystem:process(entity, dt)
  local interval = 10

  if entity.difficultyTimer < interval then
    entity.difficultyTimer = entity.difficultyTimer + dt
    return
  end

  -- Increase the difficulty
  entity.difficultyTimer = entity.difficultyTimer - interval
  entity.spawnInterval = entity.spawnInterval * 0.95 -- Increase spawn rate by 5%
  entity.spawnCount = entity.spawnCount * 1.15       -- Increase enemy speed by 15%
end

return DifficultySystem
