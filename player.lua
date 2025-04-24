local Config = require "config"

local Player = {}
Player.__index = Player


function Player.new(x, y)
  local self        = setmetatable({}, Player)
  self.x, self.y    = x, y
  self.radius       = Config.player.radius
  self.speed        = Config.player.speed
  self.cooldownTime = Config.player.cooldownTime
  self.cooldown     = 0
  self.bullets      = {}
  return self
end

function Player:update(dt, input, enemies)
  -- 1. Handle movement
  local dx, dy = 0, 0
  if input.left then dx = dx - 1 end
  if input.right then dx = dx + 1 end
  if input.up then dy = dy - 1 end
  if input.down then dy = dy + 1 end

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
    for _, enemy in ipairs(enemies) do
      local dx = enemy.x - self.x
      local dy = enemy.y - self.y
      local distance = math.sqrt(dx * dx + dy * dy)
      if distance < closestDistance then
        closestDistance = distance
        closestEnemy = enemy
      end
    end

    self:spawnBullet(closestEnemy)
    self.cooldown = self.cooldownTime
  end

  -- 3. Update bullets
  for i = #self.bullets, 1, -1 do
    local b = self.bullets[i]
    b.x = b.x + b.vx * dt
    b.y = b.y + b.vy * dt
    if b.life <= 0 then
      table.remove(self.bullets, i)
    else
      b.life = b.life - dt
    end
  end
end

function Player:draw()
  -- Draw player
  love.graphics.setColor(0.9, 0.9, 1)
  love.graphics.circle("fill", self.x, self.y, self.radius)

  -- Draw bullets
  love.graphics.setColor(1, 0.8, 0.2)
  for _, b in ipairs(self.bullets) do
    love.graphics.circle("fill", b.x, b.y, Config.bullet.radius)
  end
end

function Player:spawnBullet(enemy)
  if not enemy then return end
  local dx = enemy.x - self.x
  local dy = enemy.y - self.y
  local distance = math.sqrt(dx * dx + dy * dy)
  if distance > 0 then
    dx = dx / distance
    dy = dy / distance
  end

  local bullet = {
    x = self.x,
    y = self.y,
    vx = dx * Config.bullet.speed,
    vy = dy * Config.bullet.speed,
    life = Config.bullet.life,
  }
  table.insert(self.bullets, bullet)
end

return Player
