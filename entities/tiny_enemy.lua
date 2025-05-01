local Config = require "config"
local Enemy = {}
Enemy.__index = Enemy

function Enemy.new(x, y)
  local self = setmetatable({}, Enemy)
  self.enemy = true
  self.pos = { x = x, y = y }
  self.vel = { x = 0, y = 0 }
  self.speed = { max = Config.enemy.speed, acceleration = Config.enemy.acceleration }
  self.friction = Config.enemy.friction
  self.collider = { type = "circle", radius = Config.enemy.radius, tag = "enemy" }
  self.hitState = 0
  self.hitBy = { x = nil, y = nil }
  self.health = Config.enemy.health
  return self
end

function Enemy:draw()
  if self.hitState > 0 then
    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(6)
    love.graphics.setLineStyle("rough")
    love.graphics.circle('line', self.pos.x, self.pos.y, self.collider.radius)
  end
  love.graphics.setColor(0.9, 0.1, 0.1)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)
end

return Enemy
