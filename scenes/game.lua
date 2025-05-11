local TinyPlayer       = require "entities.tiny_player"
local TinyEnemySpawner = require "entities.tiny_enemy_spawner"
local Gun              = require "entities.gun"

local GameScene        = {}
GameScene.__index      = GameScene

function GameScene.load()
  TinyWorld:clearEntities()

  TinyWorld:addEntity(require("entities.ui.health_bar").new())

  PLAYER = TinyPlayer.new(400, 300)
  TinyWorld:add(PLAYER)

  local gun = Gun.new()
  TinyWorld:add(gun)

  local enemySpawner = TinyEnemySpawner.new()
  TinyWorld:add(enemySpawner)
end

return GameScene
