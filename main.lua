local Config       = require "config"
local Input        = require "input"
local Player       = require "entities.player"
local Collisions   = require "systems.collisions"
local World        = require "world"
local EnemySpawner = require "systems.enemySpawner"

local player
local world
local enemySpawner

function love.load()
  math.randomseed(os.time())
  love.window.setMode(Config.window.width, Config.window.height, { resizable = false, vsync = true })
  love.window.setTitle(Config.window.title)

  world = World.new()

  player = Player.new(400, 300)
  world:setPlayer(player)

  enemySpawner = EnemySpawner.new(world)
end

function love.update(dt)
  Input.update()
  for _, entity in ipairs(world.entities) do
    entity:update(dt)
  end

  -- Run enemy spawner
  enemySpawner:update(dt)

  -- Check for collisions
  Collisions.run(world.entities)

  -- Remove entities marked for removal
  for i = #world.entities, 1, -1 do
    local entity = world.entities[i]
    if entity.removal then
      table.remove(world.entities, i)
    end
  end
end

function love.draw()
  for _, entity in ipairs(world.entities) do
    entity:draw()
  end

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
