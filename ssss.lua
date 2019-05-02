-- Scaling, sliding, something, screen
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
  _small_w = 800,
  _small_h = 600,
  _drawing = false,
  _color_a = {0, 0, 0, 0},
  _color_b = {0, 0, 0, 0},
  _cur_color = {0, 0, 0, 0},
  _lerping = false,
  _lerp_timer = 0,
  _lerp_speed = 1
}

-- private utility
local function lerp(a, b, k) --smooth transitions
  if a == b then
    return a
  else
    if math.abs(a-b) < 0.005 then return b else return a * (1-k) + b * k end
  end
end

local function deepColorCopy(a)
  local o = {}
  for i,v in ipairs(a) do
    o[i] = v
  end

  return o
end

-- public api
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
  -- fullscreening
  love.graphics.push()
  love.graphics.translate(cx, cy)
  love.graphics.scale(self._fullscreen_scale.x, self._fullscreen_scale.y)
  
  -- transformations
  love.graphics.scale(self._scale.x, self._scale.y)
  love.graphics.rotate(self._rot)
  love.graphics.translate(-self._x, -self._y)
end

function ssss:off()
  -- drawing
  if self._drawing then
    love.graphics.setColor(self._cur_color)
    love.graphics.rectangle('fill', 0, 0, 800, 600)
    love.graphics.setColor(1, 1, 1)
  end
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

-- the part that bites me
function ssss:update(dt)
  if self._lerping then
    self._lerp_timer = math.min(self._lerp_timer + self._lerp_speed * dt, 1)
    self._lerping = self._lerp_timer < 1

    for i = 1,4 do
      self._cur_color[i] = lerp(self._color_a[i], self._color_b[i], self._lerp_timer)
    end
  end
end

function ssss:fadeTo(color, speed)
  self._lerp_speed = speed or 1
  -- set color a to cur color
  self._color_a = deepColorCopy(self._cur_color)
  -- set color b to color
  self._color_b = deepColorCopy(color)

  -- reinit bools
  self._lerp_timer = 0
  self._drawing = true
  self._lerping = true
end

function ssss:setColorTo(color)
  self._cur_color = color
end

function ssss:setDraw(isDrawing)
  self._drawing = isDrawing
end

return ssss