local Tiny = require "lib.tiny"
local Config = require "config"
local Enemy = require "entities.tiny_enemy"

local EnemySpawnerSystem = Tiny.processingSystem()
EnemySpawnerSystem.filter = Tiny.requireAll('enemySpawner')

function EnemySpawnerSystem:process(entity, dt)
  -- Check if the enemy spawner is ready to spawn a new enemy
  if entity.spawnTimer <= 0 then
    -- Spawn the specified number of enemies
    for i = 1, entity.spawnCount do
      local x = math.random(0, Config.window.width)
      local y = math.random(0, Config.window.height)
      local enemy = Enemy.new(x, y)
      Tiny.addEntity(self.world, enemy)
    end

    -- Reset the spawn timer
    entity.spawnTimer = entity.spawnInterval
  else
    -- Decrease the spawn timer
    entity.spawnTimer = entity.spawnTimer - dt
  end
end

return EnemySpawnerSystem
