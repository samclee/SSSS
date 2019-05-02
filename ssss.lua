-- Scaling, sliding, shaking, screen
-- GeneRally IDioMatic And Neat
-- SSSS.Gridman

local ssss = {
  _x = 0,
  _y = 0,
  _rot = 0,
  _fullscreen_scale = {x = 1, y = 1},
  _offset = {x = 0, y = 0},
  _scale = {x = 1, y = 1},
  _fullscreen = false,
  _small_x = 800,
  _small_y = 600
}

function ssss:init()
  local w,h = love.graphics.getWidth(), love.graphics.getHeight()
  ssss:lookAt(w/2, h/2)
end

function ssss:on()
  local w,h = love.graphics.getWidth(), love.graphics.getHeight()
  local cx, cy = w/2, h/2
  love.graphics.setScissor(self._offset.x, self._offset.y, 
                            800 * self._fullscreen_scale.x,
                            600 * self._fullscreen_scale.y)
  love.graphics.push()
  love.graphics.translate(cx, cy)
  love.graphics.scale(self._fullscreen_scale.x, self._fullscreen_scale.y)
  love.graphics.scale(self._scale.x, self._scale.y)
  love.graphics.rotate(self._rot)
  love.graphics.translate(-self._x, -self._y)
end

function ssss:off()
  love.graphics.pop()
end

-- the part that bites hump.camera
function ssss:lookAt(x, y)
  self._x, self._y = x, y
end

function ssss:rotate(phi)
  self._rot = self._rot + phi
end

function ssss:zoom()

end

-- that part that bites push
function ssss:setFullscreen(isFullscreen)
  love.window.setFullscreen(self._fullscreen, 'desktop')
  
  if self._fullscreen then
    -- scale screen to desktop
    local ww, wh = love.window.getDesktopDimensions()
    local sx ,sy = ww/800, wh/600
    print(sx ..'  ' .. sy)
    local scale = math.min(sx, sy)
    self._fullscreen_scale.x, self._fullscreen_scale.y = scale, scale

    -- scissor screen
    local ox, oy = (sx - scale) * 400, (sy - scale) * 300
    self._offset.x, self._offset.y = ox, oy
  else
    self._fullscreen_scale.x, self._fullscreen_scale.y = 1, 1
    self._offset.x, self._offset.y = 0, 0
  end
end

function ssss:toggleFullscreen()
  self._fullscreen = not self._fullscreen
  self:setFullscreen(self._fullscreen)
end

-- the part that bites shack
function ssss:shake()

end

function ssss:update(dt)

end

-- the part that bites me
function ssss:fadeTo(color)

end

function ssss:setColorTo(color)

end

return ssss