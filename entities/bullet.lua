local Config = require "config"
local Collider = require "components.collider"
local Entity = require "entities.entity"
local Position = require "components.position"

local Bullet = {}
Bullet.__index = Bullet

---Create a new Bullet instance.
---@param x number The x-coordinate of the bullet's initial position.
---@param y number The y-coordinate of the bullet's initial position.
---@param target {x: number, y: number} The target position to which the bullet will move.
---@return table
function Bullet.new(x, y, target)
  local self = Entity.new("bullet")
      :add(Position.new(x, y))
      :add(Collider.circle(Config.bullet.radius))
  setmetatable(self, Bullet)

  self.speed = Config.bullet.speed
  self.life = Config.bullet.life
  self.removal = false

  -- Calculate the direction vector towards the target
  local dx = target.x - x
  local dy = target.y - y
  local length = math.sqrt(dx * dx + dy * dy)

  if length > 0 then
    self.vx = (dx / length) * self.speed
    self.vy = (dy / length) * self.speed
  else
    self.vx, self.vy = 0, 0
  end

  return self
end

function Bullet:update(dt)
  self.pos.x = self.pos.x + self.vx * dt
  self.pos.y = self.pos.y + self.vy * dt

  if self.life <= 0 then
    self.removal = true
  else
    self.life = self.life - dt
  end
end

function Bullet:draw()
  love.graphics.setColor(1, 0.8, 0.2)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)
end

function Bullet:hit()
  self.removal = true
end

return Bullet
