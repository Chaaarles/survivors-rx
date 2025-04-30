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
  return self
end

function Enemy:draw()
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)
end

return Enemy
