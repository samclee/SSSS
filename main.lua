local ssss = require 'ssss'
lg = love.graphics
lk = love.keyboard

-- push
local gameWidth, gameHeight = 480, 360 --fixed game resolution

-- camera
cam_pos = {x = 400, y = 300}

function love.load()
  bg = lg.newImage('rooms.png')
  ssss:init()
end

function love.update(dt)
  if lk.isDown('left') then cam_pos.x = cam_pos.x - 3 end
  if lk.isDown('right') then cam_pos.x = cam_pos.x + 3 end

  ssss:lookAt(cam_pos.x, cam_pos.y)
  ssss:update(dt)
end

function love.draw()
  ssss:on()
  
  lg.draw(bg)
  lg.setColor(1,0,0)
  lg.rectangle('fill',0,0,10,10)
  lg.rectangle('fill',790,590,10,10)
  lg.setColor(1,1,1)
  
  ssss:off()
end

function love.keypressed(k)
  if k == 'f' then
    ssss:toggleFullscreen()
  elseif k == 'escape' then
    love.event.quit()
  elseif k == 'q' then
    ssss:fadeTo({1, 0, 0, 1})
  elseif k == 'w' then
    ssss:fadeTo({0, 1, 1, 1}, 0.5)
  elseif k == 'e' then
    ssss:fadeTo({1, 1, 1, 0}, 2)
  elseif k == 'r' then
    ssss:fadeTo({1, 1, 1, 1})
  end
end