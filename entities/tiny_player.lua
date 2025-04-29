local config = require "config"
local Player = {}
Player.__index = Player

function Player.new(x, y)
  local self = setmetatable({}, Player)
  self.playerController = true;
  self.pos = { x = x, y = y }
  self.vel = { x = 0, y = 0 }
  self.speed = { max = config.player.speed, acceleration = config.player.acceleration }
  self.friction = config.player.friction
  self.cooldownTime = config.player.cooldownTime
  self.cooldown = 0
  self.collider = { type = "circle", radius = 10 }
  return self
end

function Player:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)
end

return Player
