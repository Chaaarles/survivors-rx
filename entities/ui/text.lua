local Text = {}
Text.__index = Text

--- Initialize a new Text instance.
---@param x number
---@param y number
---@param text string
---@param font love.Font
---@param anchorX "left"|"center"|"right"
---@param anchorY "top"|"center"|"bottom"
---@param color table
---@return table
function Text.new(x, y, text, font, anchorX, anchorY, color)
  local self = setmetatable({}, Text)
  self.userInterface = true
  self.x = x
  self.y = y
  self.text = text
  self.font = font
  self.anchorX = anchorX or "left"
  self.anchorY = anchorY or "top"
  self.color = color or { 1, 1, 1 }
  return self
end

function Text:draw()
  love.graphics.setColor(self.color)
  love.graphics.setFont(self.font)

  local textWidth = self.font:getWidth(self.text)
  local textHeight = self.font:getHeight()

  local xOffset = 0
  if self.anchorX == "center" then
    xOffset = -textWidth / 2
  elseif self.anchorX == "right" then
    xOffset = -textWidth
  end

  local yOffset = 0
  if self.anchorY == "center" then
    yOffset = -textHeight / 2
  elseif self.anchorY == "bottom" then
    yOffset = -textHeight
  end

  love.graphics.print(self.text, self.x + xOffset, self.y + yOffset)
end

return Text
