local Position = {}
Position.__index = Position

Position.tag = "pos"

Position.new = function(x, y)
  return setmetatable({ x = x, y = y }, Position)
end

return Position
