require './config'
require './merge-textures'

-- Specify which map to generate
require 'make-texture/texture_mappings/main_terrain/mapping'

math.randomseed(os.time())

function love.load()
  initializeApp()

  local myTable = {}

  local mapping_data = {}

  mapping_data['tileResolution'] = tileResolution
  mapping_data['tilesX'] = 3
  mapping_data['tilesY'] = 3
  mapping_data['alphamaskTex2'] = 'alphatex_new_layer2.png'
  mapping_data['alphamaskTex3'] = 'alphatex_new_layer3.png'

  -- mapping_data['tex1'] = 'tex1.png'
  -- mapping_data['tex2'] = 'tex2.png'
  -- mapping_data['tex3'] = 'tex3.png'

  for key,value in pairs(texKeys) do --actualcode
    mapping_data['tex1'] = 'textures/' .. value[1] .. '.png'

    if value[2] ~= nil then
      mapping_data['tex2'] = 'textures/' .. value[2][2] .. '.png'
      if value[3] ~= nil then
        mapping_data['tex3'] = 'textures/' .. value[3] .. '.png'
      else
        mapping_data['tex3'] = nil
      end
    else
      mapping_data['tex2'] = nil
      mapping_data['tex3'] = nil
    end

    print(mapping_data['tex1'])
    mergedTexture = mergeTextures(mapping_data)

  end


  -- mergedTexture = mergeTextures(mapping_data)
end

function love.draw()



  xrl.drawDebugGrid()
  love.graphics.setColor(1, 1, 1, 1)

  -- love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setBlendMode("alpha")
  -- love.graphics.draw(mergedTexture, 0,0, 0, canvasScaleFactorX,canvasScaleFactorY)



  love.graphics.setColor(0,1,0,1)

  xrl.drawDebugInfo()
end