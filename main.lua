local Config  = require "config"
local Player  = require "player"
local Input   = require "input"
local Enemy   = require "enemy"

local player
local enemies = {}

function love.load()
  math.randomseed(os.time())
  love.window.setMode(Config.window.width, Config.window.height, { resizable = false, vsync = true })
  player = Player.new(400, 300)

  for i = 1, 5 do
    local x = math.random(0, Config.window.width)
    local y = math.random(0, Config.window.height)
    local enemy = Enemy.new(x, y)
    table.insert(enemies, enemy)
  end

  love.window.setTitle(Config.window.title)
end

function love.update(dt)
  Input.update()
  player:update(dt, Input, enemies)
  for _, enemy in ipairs(enemies) do
    enemy:update(dt, player)
  end
end

function love.draw()
  player:draw()
  for _, enemy in ipairs(enemies) do
    enemy:draw()
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end
