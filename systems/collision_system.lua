local CollisionSystem = Tiny.system()
CollisionSystem.filter = Tiny.requireAll('pos', 'collider')

local SpatialHash = require('spatial_hash')
local hash = SpatialHash.new(48) -- 64x64 cells

--- Check if two circles overlap
local function circlesOverlap(a, b)
  local dx = b.pos.x - a.pos.x
  local dy = b.pos.y - a.pos.y
  local distanceSquared = dx * dx + dy * dy
  local radiusSum = a.collider.radius + b.collider.radius
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
    moveColliders(a, b, 0.05)
    if a.hitBuffer == nil then
      return
    end

    table.insert(a.hitBuffer,
      {
        source = b,
        effects = {
          { type = "damage",       value = 1 },
          { type = "invulnerable", duration = 0.5 } }
      })
  end,
  enemyEnemy = function(a, b, world)
    -- Move the enemies apart
    moveColliders(a, b, 0.5)
  end,
  bulletEnemy = function(a, b, world)
    -- Handle bullet and enemy collision
    if b.hitBuffer == nil then
      return
    end

    table.insert(b.hitBuffer,
      {
        source = a,
        effects = {
          { type = "damage",    value = 1 },
          { type = "knockback", x = a.vel.x,        y = a.vel.y },
          { type = "stun",      duration = 0.3 },
          { type = "sound",     sound = a.hitSound, seek = 0.08, pitch_variance = 0.2 },
        }
      })
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
  hash:clear()

  for i = 1, #self.entities do
    hash:insert(self.entities[i])
  end


  for i = 1, #self.entities do
    local a = self.entities[i]
    local buckets, m = hash:bucketsFor(a)
    for bucketIndex = 1, m do
      local bucket = buckets[bucketIndex]
      if bucket then
        for j = 1, bucket.n do
          local b = bucket[j]
          if b ~= a
              and a.id < b.id
              and (circlesOverlap(a, b))
          then
            dispatch(a, b, self.world)
          end
        end
      end
    end
  end
end

return CollisionSystem
