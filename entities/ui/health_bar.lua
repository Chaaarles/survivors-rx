local HealthBar = {}
HealthBar.__index = HealthBar

function HealthBar.new()
  local self = setmetatable({}, HealthBar)
  self.userInterface = true
  self.x = 10
  self.y = 10
  self.width = 120
  self.height = 20
  self.borderWidth = 2
  return self
end

function HealthBar:draw()
  love.graphics.setColor(0.2, 0.2, 0.2)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle('fill', self.x + self.borderWidth, self.y + self.borderWidth,
    (self.width - self.borderWidth * 2) * (PLAYER.health.value / PLAYER.health.max), self.height - self.borderWidth * 2)

  local healthText = string.format("%d / %d", PLAYER.health.value, PLAYER.health.max)
  local textWidth = love.graphics.getFont():getWidth(healthText)
  local textHeight = love.graphics.getFont():getHeight()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(healthText, self.x + (self.width - textWidth) / 2, self.y + (self.height - textHeight) / 2)
end

return HealthBar
