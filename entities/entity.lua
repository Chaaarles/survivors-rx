local Entity = {}
Entity.__index = Entity


function Entity.new(tag)
  return setmetatable({
    tag = tag,
  }, Entity)
end

---Add a component to the entity.
---@param component {tag: string, [any]: any} The component to add.
function Entity:add(component)
  self[component.tag] = component
  return self
end

---Update the entity.
---@param dt number The delta time since the last update.
function Entity:update(dt) end

---Draw the entity.
function Entity:draw() end

return Entity
