require './config'
require './merge-textures'

-- Specify which map to generate
require 'make-texture/texture_mappings/main_terrain/mapping'

math.randomseed(os.time())

function love.load()
  initialize()

  tiles_x = 3
  tiles_y = 9
  canvasWidth = 1536
  canvasHeight = 4608

  local mapping_data = {}

  mapping_data['tile_resolution'] = 512
  mapping_data['tex1'] = 'tex1.png'
  mapping_data['tex2'] = 'tex2.png'
  mapping_data['tex3'] = 'tex3.png'
  mapping_data['alphamask_tex2'] = 'alphatex.png'
  mapping_data['alphamask_tex3'] = 'alphatex.png'

  mapping_data['tiles_x'] = 3
  mapping_data['tiles_y'] = 9

  local mergedTexture = mergeTextures(mapping_data)
end

function love.draw()

  love.graphics.setColor(1, 1, 1, 1)

  -- love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setBlendMode("alpha")

  love.graphics.draw(canvas, 0,0, 0, canvasScaleFactorX,canvasScaleFactorY)

  -- love.graphics.setShader()
  -- love.graphics.setBlendMode("alpha")

  love.graphics.setColor(0,1,0,1)

  love.graphics.print('Canvas: ' .. canvasWidth .. 'px stretched to ' .. canvasWidth * canvasScaleFactorX .. 'px', 0, 0)
  love.graphics.print('Canvas: ' .. canvasHeight .. 'px stretched to ' .. canvasHeight * canvasScaleFactorY .. 'px', 0, 20)
end