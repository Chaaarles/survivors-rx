local Config = require "config"
local Player = {}
Player.__index = Player

function Player.new(x, y)
  local self = setmetatable({}, Player)
  self.id = NewId()
  self.playerController = true;
  self.pos = { x = x, y = y }
  self.vel = { x = 0, y = 0 }
  self.speed = { max = Config.player.speed, acceleration = Config.player.acceleration }
  self.friction = Config.player.friction
  self.cooldownTime = Config.player.cooldownTime
  self.cooldown = 0
  self.collider = { type = "circle", radius = Config.player.radius, tag = "player" }
  return self
end

local sprite = love.graphics.newImage("assets/graphics/gun.png")

function Player:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)
  love.graphics.setColor(1, 1, 0, 0.3)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)

  local scale = self.collider.radius / sprite:getWidth() * 3
  local xFactor = 1
  local angle = math.atan2(self.vel.y, self.vel.x)

  -- Draw the sprite tangential to circle
  local xOffset = math.cos(angle) * (self.collider.radius * 0.7 + sprite:getWidth() / 2 * scale)
  local yOffset = math.sin(angle) * (self.collider.radius * 0.7 + sprite:getWidth() / 2 * scale)

  if self.vel.x < 0 then
    xFactor = -1
    angle = angle + math.pi
  end

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(
    sprite,
    self.pos.x + xOffset,
    self.pos.y + yOffset,
    angle,
    scale * xFactor,
    scale,
    sprite:getWidth() / 2,
    sprite:getHeight() / 2)
end

return Player
