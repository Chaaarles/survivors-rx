local Button = {}
Button.__index = Button

function Button.new(x, y, paddingX, paddingY, text, font, anchorX, anchorY, color, hoverColor, action)
  local self = setmetatable({}, Button)
  self.userInterface = true
  self.hover = false
  self.click = false

  local textWidth = font:getWidth(text)
  local textHeight = font:getHeight()
  local width = textWidth + paddingX * 2
  local height = textHeight + paddingY * 2

  local xOffset = 0
  if anchorX == "center" then
    xOffset = -width / 2
  elseif anchorX == "right" then
    xOffset = -width
  end
  local yOffset = 0
  if anchorY == "center" then
    yOffset = -height / 2
  elseif anchorY == "bottom" then
    yOffset = -height
  end

  self.pos = { x = x + xOffset, y = y + yOffset }
  self.size = { width = width, height = height }
  self.text = text
  self.font = font
  self.padding = { x = paddingX, y = paddingY }

  self.color = color or { 1, 1, 1 }
  self.hoverColor = hoverColor or { 0, 1, 1 }
  self.action = action
  return self
end

function Button:draw()
  love.graphics.setColor(self.color)
  if (self.hover) then
    love.graphics.setColor(self.hoverColor)
  end
  love.graphics.setFont(self.font)

  love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.width, self.size.height)
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(self.text, self.pos.x + self.padding.x, self.pos.y + self.padding.y)
end

return Button
