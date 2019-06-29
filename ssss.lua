-- Scaling, sliding, something, screen
-- GeneRally IDioMatic And Neat
-- SSSS.Gridman

local ssss = {
  -- screensize
  _offset = {x = 0, y = 0},
  _scale = {x = 1, y = 1},
  _fullscreen = false,
  _game_w = 800,
  _game_h = 600,
  _display_w = 800,
  _display_h = 600,

  -- camera
  _x = 0,
  _y = 0

}

-- internal functions
function ssss:calcValues()
  -- calculate scaling needed for each dim
  local sx = self._display_w / self._game_w
  local sy = self._display_h / self._game_h
  local min_scale = math.min(sx, sy)

  -- calculate offset needed to center the game screen
  self._offset.x = (sx - min_scale) * self._game_w / 2
  self._offset.y = (sy - min_scale) * self._game_h / 2

  -- apply scaling
  self._scale.x, self._scale.y = min_scale, min_scale
end

-- public api
function ssss:init(gw, gh, dw, dh)
  self._game_w, self._game_h = gw, gh
  self._display_w, self._display_h = dw, dh
  self._x, self._y = gw / 2, gh / 2
  print(self._x .. ', ' .. self._y)
  self:calcValues()
end

function ssss:on(no_cam)
  -- scaling and centering
  love.graphics.translate(self._offset.x, self._offset.y)
  love.graphics.setScissor(self._offset.x, self._offset.y, self._game_w * self._scale.x, self._game_h * self._scale.y)
  love.graphics.push()
  love.graphics.scale(self._scale.x, self._scale.y)

  -- camera
  if not no_cam then
    local cx,cy = self._game_w / 2, self._game_h / 2
    local dx, dy = cx - self._x, cy - self._y
    love.graphics.translate(dx, dy)
  end
end

function ssss:off()
  love.graphics.pop()
end

-- Fullscreen functions
function ssss:toggleFullscreen()
  self._fullscreen = not self._fullscreen
  local ww, wh = love.window.getDesktopDimensions()

  if self._fullscreen then -- windowed to fullscreen
    self._holding_w, self._holding_h = self._display_w, self._display_h
    self._display_w, self._display_h = ww, wh
  else -- fullscreen to windowed
    self._display_w, self._display_h = self._holding_w, self._holding_h
  end

  self:calcValues()

  love.window.setFullscreen(self._fullscreen, 'desktop')
end

function ssss:resize(w, h)
  self._display_w, self._display_h = w, h
  self:calcValues()
end

-- Camera functions
function ssss:lookAt(x,y)
  self._x = x
  self._y = y
end

function ssss:moveBy(dx, dy)
  self._x = self._x + dx
  self._y = self._y + dy
end

return ssss