local HealthBar = {}
HealthBar.__index = HealthBar

local font = love.graphics.newFont("assets/fonts/Righteous-Regular.ttf", 14)

function HealthBar.new()
  local self = setmetatable({}, HealthBar)
  self.userInterface = true
  self.x = 10
  self.y = 10
  self.paddingX = 25
  self.paddingY = 2
  self.borderWidth = 4
  return self
end

function HealthBar:draw()
  love.graphics.setFont(font)
  local healthText = string.format("%d / %d", PLAYER.health.value, PLAYER.health.max)
  local textWidth = love.graphics.getFont():getWidth(healthText)
  local textHeight = love.graphics.getFont():getHeight()

  local width = textWidth + self.paddingX * 2
  local height = textHeight + self.paddingY * 2

  love.graphics.setColor(0.2, 0.2, 0.2)
  love.graphics.rectangle('fill', self.x, self.y, width + self.borderWidth * 2, height + self.borderWidth * 2)
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle('fill', self.x + self.borderWidth, self.y + self.borderWidth,
    (width) * (PLAYER.health.value / PLAYER.health.max), height)

  love.graphics.setColor(1, 1, 1)
  love.graphics.print(healthText, self.x + (width - textWidth) / 2 + self.borderWidth,
    self.y + (height - textHeight) / 2 + self.borderWidth)
end

return HealthBar
