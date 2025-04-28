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
    str = str .. string.format(" - Player at (%.2f, %.2f)\n", self.player.pos.x, self.player.pos.y)
  else
    str = str .. " - No player set\n"
  end

  for _, entity in ipairs(self.entities) do
    if (not entity.tag) then
      str = str .. " - No tag\n"
    elseif (not entity.pos) then
      str = str .. string.format(" - %s at no_pos\n", entity.tag)
    else
      str = str ..
          string.format(" - %s at (%.2f, %.2f)\n", entity.tag, entity.pos.x, entity.pos.y)
    end
  end

  return str
end

return World
