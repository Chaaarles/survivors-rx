local Config = require "config"
local Player = require "player"
local Input  = require "input"

local player

function love.load()
  love.window.setMode(Config.window.width, Config.window.height, { resizable = false, vsync = true })
  player = Player.new(400, 300)
  love.window.setTitle(Config.window.title)
end

function love.update(dt)
  Input.update()
  player:update(dt, Input)
end

function love.draw()
  player:draw()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end
