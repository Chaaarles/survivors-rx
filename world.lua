local World = {}
World.__index = World

local instance = nil

function World.new()
  local self = setmetatable({}, World)
  self.entities = {}
  self.player = nil
  instance = self
  return self
end

function World.getInstance()
  if not instance then
    instance = World.new()
  end
  return instance
end

function World:add(entity)
  table.insert(self.entities, entity)
end

function World:setPlayer(player)
  self.player = player
  self:add(player)
end

World.__tostring = function(self)
  local str = "World contents:\n"
  if self.player then
    str = str .. string.format(" - Player at (%.2f, %.2f)\n", self.player.x, self.player.y)
  else
    str = str .. " - No player set\n"
  end
  for _, entity in ipairs(self.entities) do
    str = str .. string.format(" - %s at (%.2f, %.2f)\n", entity.tag, entity.x, entity.y)
  end
  return str
end

return World
