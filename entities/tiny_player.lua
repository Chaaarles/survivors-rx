local Config = require "config"
local Player = {}
Player.__index = Player

function Player.new(x, y)
  local self = setmetatable({}, Player)
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

function Player:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)
end

return Player
