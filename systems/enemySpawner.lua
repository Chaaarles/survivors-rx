local Enemy = require "entities.enemy"
local Config = require "config"
local Entity = require "entities.entity"

local EnemySpawner = {}
EnemySpawner.__index = EnemySpawner

function EnemySpawner.new(world)
  local self = setmetatable(Entity.new("EnemySpawner"), EnemySpawner)
  self.world = world
  self.spawnCount = Config.enemy.spawnCount
  self.spawnInterval = Config.enemy.spawnInterval
  self.spawnTimer = 0
  return self
end

function EnemySpawner:update(dt)
  self.spawnTimer = self.spawnTimer + dt
  if self.spawnTimer >= self.spawnInterval then
    for i = 1, self.spawnCount do
      local x = math.random(0, Config.window.width)
      local y = math.random(0, Config.window.height)
      local enemy = Enemy.new(x, y)
      self.world:add(enemy)
    end

    self.spawnTimer = 0
  end
end

return EnemySpawner
