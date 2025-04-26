local Config = require "config"

local Collisions = {}

--- Check if two circles overlap
---@param a {x: number,y: number,radius: number} Circle A
---@param b {x: number,y: number,radius: number} Circle B
local function circlesOverlap(a, b)
  local dx = b.x - a.x
  local dy = b.y - a.y
  local distanceSquared = dx * dx + dy * dy
  local radiusSum = a.radius + b.radius
  return distanceSquared < radiusSum * radiusSum
end

---Calculate the movement of two objects based on their collision
---@param a {x: number,y: number,radius: number} Circle A
---@param b {x: number,y: number,radius: number} Circle B
---@param ratio number How much to move circle A. 0 = move B, 1 = move A, 0.5 = move both equally
local function moveColliders(a, b, ratio)
  local dx = b.x - a.x
  local dy = b.y - a.y
  local dist2 = dx * dx + dy * dy

  if dist2 == 0 then
    return
  end

  local distance = math.sqrt(dist2)
  local overlap = a.radius + b.radius - distance

  if overlap > 0 then
    local moveX = (dx / distance) * overlap
    local moveY = (dy / distance) * overlap
    a.x = a.x - moveX * ratio
    a.y = a.y - moveY * ratio
    b.x = b.x + moveX * (1 - ratio)
    b.y = b.y + moveY * (1 - ratio)
  end
end

local Matrix = {
  player = {
    enemy = "playerEnemy",
  },
  enemy = {
    enemy = "enemyEnemy",
  },
  bullet = {
    enemy = "bulletEnemy",
  }
}

local Handlers = {
  playerEnemy = function(a, b)
    -- Move the enemy out of the way
    moveColliders(a, b, 0)
  end,
  enemyEnemy = function(a, b)
    -- Move the enemies apart
    moveColliders(a, b, 0.5)
  end,
  bulletEnemy = function(a, b)
    -- Handle bullet and enemy collision
    a:hit()
    b:hurt()

    -- Give the enemy some knockback
    local dx = b.x - a.x
    local dy = b.y - a.y
    local distance = math.sqrt(dx * dx + dy * dy)
    if distance > 0 then
      dx = dx / distance
      dy = dy / distance
    end
    b.x = b.x + dx * 15
    b.y = b.y + dy * 15
  end,
}

local function dispatch(a, b)
  local row = Matrix[a.tag]
  local rule = row and row[b.tag]

  if rule then
    Handlers[rule](a, b)
    return
  end

  local reverseRow = Matrix[b.tag]
  local reverseRule = reverseRow and reverseRow[a.tag]
  if reverseRule then
    Handlers[reverseRule](b, a)
    return
  end
end

function Collisions.run(objects)
  for i = 1, #objects - 1 do
    local a = objects[i]
    for j = i + 1, #objects do
      local b = objects[j]
      if (circlesOverlap(a, b)) then
        dispatch(a, b)
      end
    end
  end
end

return Collisions
