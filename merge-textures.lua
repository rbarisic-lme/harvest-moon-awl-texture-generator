require 'xrl-lib/draw_functions'

function mergeTextures(data)
  -----------------------------------------------------------------------------
  -- initialize
  local tr = data.tileResolution
  local tex1 = data.tex1
  local tex2 = data.tex2
  local tex3 = data.tex3
  local alphamaskTex2 = data.alphamaskTex2
  local alphamaskTex3 = data.alphamaskTex3
  local tilesX = data.tilesX
  local tilesY = data.tilesY

  -----------------------------------------------------------------------------
  -- initialize canvas
  local outputCanvas = love.graphics.newCanvas(canvasWidth, canvasHeight)
  love.graphics.setCanvas(outputCanvas)
  love.graphics.clear()
  love.graphics.setColor(1, 1, 0,1)
  love.graphics.setBlendMode("alpha")
  love.graphics.setNewFont(100) -- 12 is the base font size at 16px

  -----------------------------------------------------------------------------
  -- draw debug grid
  xrl.drawDebugGrid()

  -- love.graphics.setCanvas(outputCanvas)
  -----------------------------------------------------------------------------
  -- draw the texture layers to the output canvas
  xrl.drawTextureShaded(tex1, nil, outputCanvas)
  xrl.drawTextureShaded(tex2, alphamaskTex2, outputCanvas)
  xrl.drawTextureShaded(tex3, alphamaskTex3, outputCanvas)

  -----------------------------------------------------------------------------
  -- reset love draw variables
  love.graphics.setCanvas()
  love.graphics.setNewFont(16) -- 12 is the base font size at 16px

  -----------------------------------------------------------------------------
  -- finally, return the canvas
  return outputCanvas
end
