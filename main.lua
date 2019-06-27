local ssss = require 'ssss'
local push = require 'push'
lg = love.graphics
lk = love.keyboard

-- push
local gameWidth, gameHeight = 960, 540 --fixed game resolution
local windowWidth, windowHeight = 960, 540 -- window size, must match conf.lua


function love.load()
  bg = lg.newImage('test.png')
  ssss:init(gameWidth, gameHeight, windowWidth, windowHeight)
end

function love.update(dt)
  local dx,dy = 0,0
  if lk.isDown('left') then
    dx = dx - 10
  elseif lk.isDown('right') then
    dx = dx + 10
  end

  ssss:moveBy(dx,0)

end


function love.draw()
  ssss:on()

  lg.draw(bg)
  lg.setColor(1,0,0)
  lg.rectangle('line',390,290,20,20)
  lg.rectangle('line',0,0,800,600)
  lg.setColor(1,1,1)
  
  ssss:off()

end

function love.keypressed(k)
  if k == 'f' then
    ssss:toggleFullscreen()
  elseif k == 'escape' then
    love.event.quit()
  elseif k == 'q' then
    ssss:lookAt(0, 0)
  elseif k == 'r' then
    ssss:lookAt(400, 300)
  end
end