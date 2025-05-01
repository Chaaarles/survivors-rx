local Config = require "config"

local EnemySpawner = {}
EnemySpawner.__index = EnemySpawner

function EnemySpawner.new()
  local self = setmetatable({}, EnemySpawner)
  self.enemySpawner = true
  self.spawnCount = Config.enemy.spawnCount
  self.spawnInterval = Config.enemy.spawnInterval
  self.spawnTimer = 0
  self.difficultyTimer = 0
  return self
end

return EnemySpawner
