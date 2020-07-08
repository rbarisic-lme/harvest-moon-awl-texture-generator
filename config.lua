require 'xrl-lib/get_scaling'

function initializeApp()
  -- initialize window
  love.window.setMode( 800,800)

  -- define global variables
  tr = 512
  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()


  tilesX = 3
  tilesY = 3
  tileResolution = 512

  canvasWidth = tilesX * tileResolution
  canvasHeight = tilesY * tileResolution

  canvasScaleFactorX, canvasScaleFactorY = getScalingFor(windowWidth,windowHeight,canvasWidth,canvasHeight)
end