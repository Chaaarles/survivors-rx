--[[
    This file contains the main menu scene for the game.
    It initializes the main menu scene, sets up the background,
    and handles the button actions for starting the game and quitting.
  ]]
local Text = require("entities.ui.text")
local Button = require("entities.ui.button")
local config = require("config")

local MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu.load()
  TinyWorld:clearEntities()

  local titleFont = love.graphics.newFont("assets/fonts/KenneyBold.ttf", 48)
  local titleText = Text.new(
    love.graphics.getWidth() / 2,
    10,
    config.window.title,
    titleFont,
    "center",
    "top",
    { 1, 1, 1 }
  )
  TinyWorld:addEntity(titleText)

  local buttonFont = love.graphics.newFont("assets/fonts/KenneyBold.ttf", 24)
  local buttonPaddingX = 8
  local buttonPaddingY = 4
  local buttonColor = { 1, 1, 1 }
  local buttonHoverColor = { 0.8, 0.8, 0.8 }

  local startButton = Button.new(
    love.graphics.getWidth() / 2,
    love.graphics.getHeight() / 2 - 50,
    buttonPaddingX,
    buttonPaddingY,
    "Start",
    buttonFont,
    "center",
    "top",
    buttonColor,
    buttonHoverColor,
    function()
      TinyWorld:clearEntities()
      require("scenes.game").load()
    end
  )
  TinyWorld:addEntity(startButton)

  local quitButton = Button.new(
    love.graphics.getWidth() / 2,
    love.graphics.getHeight() / 2 - 50 + startButton.size.height + 10,
    buttonPaddingX,
    buttonPaddingY,
    "Quit",
    buttonFont,
    "center",
    "top",
    buttonColor,
    buttonHoverColor,
    function()
      love.event.quit()
    end
  )
  TinyWorld:addEntity(quitButton)
end

return MainMenu
