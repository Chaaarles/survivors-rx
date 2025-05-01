local CollisionSystem = Tiny.system()
CollisionSystem.filter = Tiny.requireAll('pos', 'collider')


--- Check if two circles overlap
---@param a {x: number, y: number, radius: number} Circle A
---@param b {x: number, y: number, radius: number} Circle B
local function circlesOverlap(a, b)
  local dx = b.x - a.x
  local dy = b.y - a.y
  local distanceSquared = dx * dx + dy * dy
  local radiusSum = a.radius + b.radius
  return distanceSquared < radiusSum * radiusSum
end

local function moveColliders(a, b, ratio)
  local dx = b.pos.x - a.pos.x
  local dy = b.pos.y - a.pos.y
  local dist2 = dx * dx + dy * dy

  if dist2 == 0 then
    return
  end

  local distance = math.sqrt(dist2)
  local overlap = a.collider.radius + b.collider.radius - distance

  if overlap > 0 then
    local moveX = (dx / distance) * overlap
    local moveY = (dy / distance) * overlap
    a.pos.x = a.pos.x - moveX * ratio
    a.pos.y = a.pos.y - moveY * ratio
    b.pos.x = b.pos.x + moveX * (1 - ratio)
    b.pos.y = b.pos.y + moveY * (1 - ratio)

    a.vel.x = a.vel.x - moveX * ratio * 10
    a.vel.y = a.vel.y - moveY * ratio * 10
    b.vel.x = b.vel.x + moveX * (1 - ratio) * 10
    b.vel.y = b.vel.y + moveY * (1 - ratio) * 10
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
  playerEnemy = function(a, b, world)
    -- Move the enemy out of the way
    moveColliders(a, b, 0.2)
  end,
  enemyEnemy = function(a, b, world)
    -- Move the enemies apart
    moveColliders(a, b, 0.5)
  end,
  bulletEnemy = function(a, b, world)
    -- Handle bullet and enemy collision
    b.hitBy.x, b.hitBy.y = a.vel.x, a.vel.y
    Tiny.removeEntity(world, a) -- Remove the bullet entity
  end,
}

local function dispatch(a, b, world)
  local row = Matrix[a.collider.tag]
  local rule = row and row[b.collider.tag]

  if rule then
    Handlers[rule](a, b, world)
    return
  end

  local reverseRow = Matrix[b.collider.tag]
  local reverseRule = reverseRow and reverseRow[a.collider.tag]
  if reverseRule then
    Handlers[reverseRule](b, a, world)
    return
  end
end

function CollisionSystem:update(dt)
  local objects = self.entities

  for i = 1, #objects - 1 do
    local a = objects[i]
    for j = i + 1, #objects do
      local b = objects[j]
      if (circlesOverlap({ x = a.pos.x, y = a.pos.y, radius = a.collider.radius }, { x = b.pos.x, y = b.pos.y, radius = b.collider.radius })) then
        dispatch(a, b, self.world)
      end
    end
  end
end

return CollisionSystem
