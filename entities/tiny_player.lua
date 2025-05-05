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

local gun = love.graphics.newImage("assets/graphics/gun.png")
local king = love.graphics.newImage("assets/graphics/tile_0137.png")
king:setFilter("nearest", "nearest")

function Player:draw()
  love.graphics.setColor(1, 1, 1)
  local kingScale = 2
  love.graphics.draw(king, math.floor(self.pos.x), math.floor(self.pos.y), 0, kingScale, kingScale,
    king:getWidth() / 2, (king:getHeight() / 2) + 2)

  local scale = self.collider.radius / gun:getWidth() * 3
  local xFactor = 1
  local angle = math.atan2(self.vel.y, self.vel.x)

  local angleClamper = 5
  if angle >= math.pi / angleClamper and angle <= math.pi / 2 then
    angle = math.pi / angleClamper
  elseif angle > math.pi / 2 and angle <= math.pi - math.pi / angleClamper then
    angle = math.pi - math.pi / angleClamper
  elseif angle < -math.pi / angleClamper and angle >= -math.pi / 2 then
    angle = -math.pi / angleClamper
  elseif angle < -math.pi / 2 and angle > -math.pi + math.pi / angleClamper then
    angle = -math.pi + math.pi / angleClamper
  end


  -- Draw the sprite tangential to circle
  local xOffset = math.cos(angle) * (self.collider.radius * 0.7 + gun:getWidth() / 2 * scale)
  local yOffset = math.sin(angle) * (self.collider.radius * 0.7 + gun:getWidth() / 2 * scale)

  if self.vel.x < 0 then
    xFactor = -1
    angle = angle + math.pi
  end

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(
    gun,
    self.pos.x + xOffset,
    self.pos.y + yOffset,
    angle,
    scale * xFactor,
    scale,
    gun:getWidth() / 2,
    gun:getHeight() / 2)
end

return Player
