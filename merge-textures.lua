require 'xrl-lib/get_scaling'

-- extern Image image1; // the G channel should be alpha
-- extern Image image2; // the alpha of this image is ignored

-- return vec4(Texel(image2, texturepos).rgb, Texel(image1, texturepos).g) * colour;

-- Fill a new canvas with the specified texture
-- @return: new Canvas
function fillNewCanvas(texture)
  local newCanvas = love.graphics.newCanvas(canvasWidth, canvasHeight)

  love.graphics.setCanvas(newCanvas)
  love.graphics.clear()
  love.graphics.setColor(1,1,1,1)
  love.graphics.setShader()

  for i=1,tiles_x,1 do
    for j=1,tiles_y,1 do
      love.graphics.draw(texture, (i-1) * tr, (j-1) * tr, 0, tr / texture:getWidth(), tr / texture:getHeight())
    end
  end

  ------------------------------------------------------------------------------
  -- reset draw
  love.graphics.setCanvas()
  love.graphics.setBlendMode("alpha")
  love.graphics.setColor(1,1,1,1)
  ------------------------------------------------------------------------------
  return newCanvas
end


function mergeTextures(data)
  ------------------------------------------------------------------------------
  -- initialize
  local tr = data.tile_resolution
  local tex1 = data.tex1
  local tex2 = data.tex2
  local tex3 = data.tex3
  local alphamask_tex2 = data.alphamask_tex2
  local alphamask_tex3 = data.alphamask_tex3
  local tiles_x = data.tiles_x
  local tiles_y = data.tiles_y

  ------------------------------------------------------------------------------
  canvas = love.graphics.newCanvas(canvasWidth, canvasHeight)

  ------------------------------------------------------------------------------
  -- load textures
  baseTex1 = love.graphics.newImage(tex1)
  baseTex2 = love.graphics.newImage(tex2)
  baseTex3 = love.graphics.newImage(tex3)

  alphaTex = love.graphics.newImage(alphamask_tex2)

  ------------------------------------------------------------------------------
  -- load shader
  maskShaderTex2 = love.graphics.newShader("shaders/mask.fs")
  maskShaderTex2:send('alpha', alphaTex)
  ------------------------------------------------------------------------------

  tex1Canvas = fillNewCanvas(baseTex1)
  tex2Canvas = fillNewCanvas(baseTex2)
  tex3Canvas = fillNewCanvas(baseTex3)

  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.setColor(1, 1, 0,1)
  love.graphics.setBlendMode("alpha")
  love.graphics.setNewFont(100) -- 12 is the base font size at 16px

  for i=1,tiles_x,1 do
    for j=1,tiles_y,1 do

      if ((i + j) % 2) > 0 then
        c = 0.7
      else
        c = 0.2
      end

      love.graphics.setColor(c,c,c,1)
      love.graphics.rectangle( "fill", (i - 1) * tr, (j - 1) * tr, tr, tr)
      love.graphics.setColor(math.random()* 0.4,math.random()* 0.4,math.random()* 0.4,1)
    end
  end
  -- reset color
  love.graphics.setColor(1,1,1,1)



  ------------------------------------------------------------------------------
  -- draw this unshaded
  love.graphics.draw(tex3Canvas, 0,0, 0, canvasScaleFactorX,canvasScaleFactorY)
  ------------------------------------------------------------------------------


  ------------------------------------------------------------------------------
  -- draw the next texture with a mask
  love.graphics.setShader(maskShaderTex2)
  love.graphics.draw(tex2Canvas, 0,0, 0, canvasScaleFactorX,canvasScaleFactorY)
  love.graphics.setShader()
  ------------------------------------------------------------------------------

  love.graphics.setCanvas()

  -- baseTex1ScaleFactorX, baseTex1ScaleFactorY = getScalingFor(baseTex1:getWidth(),2,2,2)
  canvasScaleFactorX, canvasScaleFactorY = getScalingFor(windowWidth,windowHeight,canvasWidth,canvasHeight)
  love.graphics.setNewFont(16) -- 12 is the base font size at 16px

end
