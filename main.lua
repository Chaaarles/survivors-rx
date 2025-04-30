Tiny                   = require "lib.tiny"

local Config           = require "config"
local Input            = require "input"

local TinyPlayer       = require "entities.tiny_player"
local TinyEnemySpawner = require "entities.tiny_enemy_spawner"


local tinyWorld
local drawSystemFilter   = Tiny.requireAll("isDrawingSystem")
local updateSystemFilter = Tiny.rejectAll("isDrawingSystem")

function love.load()
  math.randomseed(os.time())
  love.window.setMode(Config.window.width, Config.window.height, { resizable = false, vsync = true })
  love.window.setTitle(Config.window.title)

  tinyWorld = Tiny.world(
    require("systems.enemy_spawner_system"),
    require("systems.player_controller_system"),
    require("systems.enemy_controller_system"),
    require("systems.enemy_velocity_clamp_system"),
    require("systems.velocity_system"),
    require("systems.friction_system"),
    require("systems.collision_system"),
    require("systems.draw_system")
  )

  PLAYER = TinyPlayer.new(400, 300)
  tinyWorld:add(PLAYER)

  local enemySpawner = TinyEnemySpawner.new()
  tinyWorld:add(enemySpawner)
end

function love.update(dt)
  Input.update()

  -- Update Tiny world
  tinyWorld:update(dt, updateSystemFilter)
end

function love.draw()
  -- Draw Tiny world
  tinyWorld:update(love.timer.getDelta, drawSystemFilter)

  love.graphics.setColor(1, 1, 1)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  love.graphics.print("entities: " .. Tiny.getEntityCount(tinyWorld), 10, 30)
  love.graphics.print("systems: " .. Tiny.getSystemCount(tinyWorld), 10, 50)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end

  if key == "r" then
    love.load()
  end
end
