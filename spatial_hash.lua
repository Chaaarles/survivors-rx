local SpatialHash = {}
SpatialHash.__index = SpatialHash

-- helper: make an integer key from 2D coords
local function key(cx, cy) -- cx,cy are cell indices (ints)
  return cx .. ',' .. cy   -- string key; simple & Lua-friendly
end

function SpatialHash.new(cellSize)
  return setmetatable({
    cellSize = cellSize,
    cells    = {} -- [key] = { ent1, ent2, ... }
  }, SpatialHash)
end

-- Convert world-space to cell indices
local function cellCoords(self, x, y)
  return math.floor(x / self.cellSize), math.floor(y / self.cellSize)
end

-- Clear all buckets (reuse tables if possible)
function SpatialHash:clear()
  for k, list in pairs(self.cells) do
    list.n = 0 -- keep table, just reset length marker
  end
end

-- Insert entity that has .pos and .collider.radius
function SpatialHash:insert(e)
  local cx, cy = cellCoords(self, e.pos.x, e.pos.y)
  local id = key(cx, cy)
  local bucket = self.cells[id]
  if not bucket then
    bucket = { n = 0 } -- we use custom 'n' to avoid ipairs GC
    self.cells[id] = bucket
  end
  local n              = bucket.n + 1
  bucket[n]            = e
  bucket.n             = n
  e.__cellX, e.__cellY = cx, cy -- cache for later
end

-- Iterator over all buckets neighbouring an entity (incl. its own)
function SpatialHash:bucketsFor(e)
  local list = {}
  local cx, cy = e.__cellX, e.__cellY
  local i = 0
  for dx = -1, 1 do
    for dy = -1, 1 do
      i = i + 1
      list[i] = self.cells[key(cx + dx, cy + dy)]
    end
  end
  -- list may contain nils; the caller should guard
  return list, i -- second return = list size
end

return SpatialHash
