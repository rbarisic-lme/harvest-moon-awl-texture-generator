require './config'
require './merge-textures'

-- Specify which map to generate
require 'make-texture/texture_mappings/main_terrain/mapping'

math.randomseed(os.time())

function love.load()
  initializeApp()

  local mapping_data = {}

  mapping_data['tileResolution'] = tileResolution
  mapping_data['tex1'] = 'tex1.png'
  mapping_data['tex2'] = 'tex2.png'
  mapping_data['tex3'] = 'tex3.png'
  mapping_data['alphamaskTex2'] = 'alphatex_new_layer2.png'
  mapping_data['alphamaskTex3'] = 'alphatex_new_layer3.png'

  mapping_data['tilesX'] = 3
  mapping_data['tilesY'] = 9

  mergedTexture = mergeTextures(mapping_data)

  
end

function love.draw()

  love.graphics.setColor(1, 1, 1, 1)

  -- love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setBlendMode("alpha")

  love.graphics.draw(mergedTexture, 0,0, 0, canvasScaleFactorX,canvasScaleFactorY)

  -- love.graphics.setShader()
  -- love.graphics.setBlendMode("alpha")

  love.graphics.setColor(0,1,0,1)

  love.graphics.print('Canvas: ' .. canvasWidth .. 'px stretched to ' .. canvasWidth * canvasScaleFactorX .. 'px', 0, 0)
  love.graphics.print('Canvas: ' .. canvasHeight .. 'px stretched to ' .. canvasHeight * canvasScaleFactorY .. 'px', 0, 20)
  love.graphics.print('View scale factor X: ' .. canvasScaleFactorX, 0, 40)
  love.graphics.print('View scale factor Y: ' .. canvasScaleFactorX, 0, 60)
end