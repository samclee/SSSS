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
  self:calcValues()
end

function ssss:on()
  -- scaling
  love.graphics.translate(self._offset.x, self._offset.y)
  love.graphics.setScissor(self._offset.x, self._offset.y, self._game_w * self._scale.x, self._game_h * self._scale.y)
  love.graphics.push()
  love.graphics.scale(self._scale.x, self._scale.y)
end

function ssss:off()
  love.graphics.pop()
end

-- that part that bites push
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

return ssss