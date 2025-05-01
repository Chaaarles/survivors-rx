local Config = require("config")

local Gun = {}
Gun.__index = Gun

function Gun.new()
  local self = setmetatable({}, Gun)
  self.gun = true
  self.cooldownTime = Config.gun.cooldownTime
  self.cooldown = 0
  return self
end

return Gun
