local push = require 'push'
local Camera = require 'camera'
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

function love.update(t)
  if lk.isDown('left') then cam_pos.x = cam_pos.x - 3 end
  if lk.isDown('right') then cam_pos.x = cam_pos.x + 3 end

  ssss:lookAt(cam_pos.x, cam_pos.y)
end

function love.draw()
  --cam:attach()
  --push:start()
  
  ssss:on()
  lg.draw(bg)
  lg.setColor(1,0,0)
  lg.rectangle('fill',0,0,10,10)
  lg.rectangle('fill',790,590,10,10)
  lg.setColor(1,1,1)
  ssss:off()
  
  --push:finish()
  --cam:detach()
end

function love.keypressed(k)
  if k == 'f' then
    ssss:toggleFullscreen()
  elseif k == 'escape' then
    love.event.quit()
  elseif k == 'r' then
    ssss:rotate(0.1)
  end
end