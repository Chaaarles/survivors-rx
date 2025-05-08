local Config = require "config"
local Enemy = {}
Enemy.__index = Enemy

function Enemy.new(x, y)
  local self = setmetatable({}, Enemy)
  self.id = NewId()
  self.enemy = true
  self.pos = { x = x, y = y }
  self.vel = { x = 0, y = 0 }
  self.speed = { max = Config.enemy.speed, acceleration = Config.enemy.acceleration }
  self.friction = Config.enemy.friction
  self.collider = { type = "circle", radius = Config.enemy.radius, tag = "enemy" }
  self.stun = { value = 0 }
  self.hitBy = { x = nil, y = nil }
  self.health = { value = Config.enemy.health }
  self.hitBuffer = {}
  return self
end

local sprite = love.graphics.newImage("assets/graphics/tile_0109.png")
function Enemy:draw()
  local scale = 2
  love.graphics.setColor(1, 1, 1)
  if self.stun.value > 0 then
    love.graphics.setColor(1, 0.3, 0.3)
  end


  love.graphics.draw(sprite, self.pos.x, self.pos.y, 0, scale, scale,
    sprite:getWidth() / 2, sprite:getHeight() / 2 - 2)
end

return Enemy
