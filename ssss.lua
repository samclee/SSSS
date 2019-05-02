-- Scaling, sliding, shaking, screen
-- GeneRally IDioMatic And Neat
-- SSSS.Gridman

local ssss = {
  _x = 0,
  _y = 0,
  _rot = 0,
  _scale = {1, 1},
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
  love.graphics.push()
  love.graphics.translate(cx, cy)
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

-- that part that bites push
function ssss:setFullscreen(isFullscreen)
  love.window.setFullscreen(self._fullscreen, 'desktop')
  
  if self._fullscreen then
    self._scale.x, self._scale.y = 1.5, 1.5
  else
    self._scale.x, self._scale.y = 1, 1
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