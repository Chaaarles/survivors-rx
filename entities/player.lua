local Config = require "config"
local Input = require "input"
local World = require "world"
local Bullet = require "entities.bullet"
local Collider = require "components.collider"
local Entity = require "entities.entity"
local Position = require "components.position"

local Player = {}
Player.__index = Player

function Player.new(x, y)
  local self = Entity.new("player")
      :add(Position.new(x, y))
      :add(Collider.circle(Config.player.radius))

  setmetatable(self, Player)

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

  self.pos.x = self.pos.x + dx * self.speed * dt
  self.pos.y = self.pos.y + dy * self.speed * dt


  -- 2. Handle shooting
  self.cooldown = self.cooldown - dt
  if self.cooldown <= 0 then
    local closestEnemy = nil
    local closestDistance = math.huge
    for _, enemy in ipairs(self.world.entities) do
      if enemy.tag ~= "enemy" then
        goto continue
      end
      local dx = enemy.pos.x - self.pos.x
      local dy = enemy.pos.y - self.pos.y
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
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)
end

function Player:spawnBullet(enemy)
  if not enemy then return end

  local bullet = Bullet.new(self.pos.x, self.pos.y, enemy.pos)
  self.world:add(bullet)
end

return Player
