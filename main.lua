local Config             = require "config"
local Input              = require "input"
local Player             = require "entities.player"
local Collisions         = require "systems.collisions"
local World              = require "world"
local EnemySpawner       = require "systems.enemySpawner"

Tiny                     = require "lib.tiny"
local TinyPlayer         = require "entities.tiny_player"

local player
local world
local enemySpawner
local tinyWorld
local drawSystemFilter   = Tiny.requireAll("isDrawingSystem")
local updateSystemFilter = Tiny.rejectAll("isDrawingSystem")

function love.load()
  math.randomseed(os.time())
  love.window.setMode(Config.window.width, Config.window.height, { resizable = false, vsync = true })
  love.window.setTitle(Config.window.title)

  world = World.new()
  tinyWorld = Tiny.world(
    require("systems.draw_system"),
    require("systems.player_controller_system"),
    require("systems.velocity_system"),
    require("systems.friction_system")
  )

  player = TinyPlayer.new(400, 300)
  tinyWorld:add(player)

  --enemySpawner = EnemySpawner.new(world)
end

function love.update(dt)
  Input.update()
  for _, entity in ipairs(world.entities) do
    entity:update(dt)
  end

  -- Run enemy spawner
  --enemySpawner:update(dt)

  -- Check for collisions
  Collisions.run(world.entities)

  -- Remove entities marked for removal
  for i = #world.entities, 1, -1 do
    local entity = world.entities[i]
    if entity.removal then
      table.remove(world.entities, i)
    end
  end

  -- Update Tiny world
  tinyWorld:update(dt, updateSystemFilter)
end

function love.draw()
  for _, entity in ipairs(world.entities) do
    entity:draw()
  end

  -- Draw Tiny world
  tinyWorld:update(love.timer.getDelta, drawSystemFilter)

  love.graphics.setColor(1, 1, 1)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  love.graphics.print("entities: " .. #world.entities, 10, 30)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end

  if key == "r" then
    love.load()
  end
end
