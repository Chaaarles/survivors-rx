local Config = require "config"
local Input = require "input"
local World = require "world"
local Bullet = require "entities.bullet"

local Player = {}
Player.__index = Player


function Player.new(x, y)
  local self        = setmetatable({}, Player)
  self.tag          = "player"
  self.x, self.y    = x, y
  self.radius       = Config.player.radius
  self.speed        = Config.player.speed
  self.cooldownTime = Config.player.cooldownTime
  self.cooldown     = 0
  self.world        = World.getInstance()
  return self
end

function Player:update(dt)
  -- 1. Handle movement
  local dx, dy = 0, 0
  if Input.left then dx = dx - 1 end
  if Input.right then dx = dx + 1 end
  if Input.up then dy = dy - 1 end
  if Input.down then dy = dy + 1 end

  if dx ~= 0 and dy ~= 0 then
    local normalizeFactor = 1 / math.sqrt(2)
    dx = dx * normalizeFactor
    dy = dy * normalizeFactor
  end

  self.x = self.x + dx * self.speed * dt
  self.y = self.y + dy * self.speed * dt


  -- 2. Handle shooting
  self.cooldown = self.cooldown - dt
  if self.cooldown <= 0 then
    local closestEnemy = nil
    local closestDistance = math.huge
    for _, enemy in ipairs(self.world.entities) do
      if enemy.tag ~= "enemy" then
        goto continue
      end
      local dx = enemy.x - self.x
      local dy = enemy.y - self.y
      local distance = math.sqrt(dx * dx + dy * dy)
      if distance < closestDistance then
        closestDistance = distance
        closestEnemy = enemy
      end
      ::continue::
    end

    self:spawnBullet(closestEnemy)
    self.cooldown = self.cooldownTime
  end
end

function Player:draw()
  -- Draw player
  love.graphics.setColor(0.9, 0.9, 1)
  love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Player:spawnBullet(enemy)
  if not enemy then return end

  local bullet = Bullet.new(self.x, self.y, enemy)
  self.world:add(bullet)
end

return Player
