Tiny                   = require "lib.tiny"

local Config           = require "config"
local Input            = require "input"

local TinyPlayer       = require "entities.tiny_player"
local TinyEnemySpawner = require "entities.tiny_enemy_spawner"
local Gun              = require "entities.gun"


TinyWorld                = Tiny.world()

local drawSystemFilter   = Tiny.requireAll("isDrawingSystem")
local updateSystemFilter = Tiny.rejectAll("isDrawingSystem")

GLOBAL_ID                = 0
function NewId()
  GLOBAL_ID = GLOBAL_ID + 1
  return GLOBAL_ID
end

function love.load()
  math.randomseed(os.time())
  love.window.setMode(Config.window.width, Config.window.height, { resizable = false, vsync = true })
  love.window.setTitle(Config.window.title)
  love.graphics.setDefaultFilter("nearest")

  TinyWorld:add(
    require("systems.enemy_spawner_system"),
    require("systems.difficulty_system"),
    require("systems.player_controller_system"),
    require("systems.gun_system"),
    require("systems.enemy_controller_system"),
    require("systems.enemy_velocity_clamp_system"),
    require("systems.velocity_system"),
    require("systems.friction_system"),
    require("systems.collision_system"),
    require("systems.stun_system"),
    require("systems.invulnerability_system"),
    require("systems.bullet_removal_system"),
    require("systems.hit_system"),
    require("systems.killer_system"),
    -- UI Systems
    require("systems.ui.hover_system"),
    require("systems.ui.click_system"),
    -- Drawing systems
    require("systems.draw_system"),
    require("systems.draw_ui_system"))

  require("scenes.main_menu").load()
end

function love.update(dt)
  Input.update()

  -- Update Tiny world
  TinyWorld:update(dt, updateSystemFilter)
end

function love.draw()
  love.graphics.clear(0.6, 0.8, 0.5)
  -- Draw Tiny world
  TinyWorld:update(love.timer.getDelta, drawSystemFilter)

  -- Draw debug information
  local debugFont = love.graphics.newFont(12)
  love.graphics.setFont(debugFont)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 200)
  love.graphics.print("entities: " .. Tiny.getEntityCount(TinyWorld), 10, 220)
  love.graphics.print("systems: " .. Tiny.getSystemCount(TinyWorld), 10, 240)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end

  if key == "r" then
    Tiny.clearEntities(TinyWorld)
    Tiny.clearSystems(TinyWorld)
    Tiny.refresh(TinyWorld)
    love.load()
  end
end
