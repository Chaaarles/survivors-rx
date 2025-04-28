local Collider = {}
Collider.__index = Collider

Collider.tag = "collider"

function Collider.circle(radius)
  return setmetatable({
    type = "circle",
    radius = radius,
  }, Collider)
end

function Collider.rect(width, height)
  return setmetatable({
    type = "rect",
    width = width,
    height = height,
  }, Collider)
end

return Collider
