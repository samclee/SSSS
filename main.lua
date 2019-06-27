local ssss = require 'ssss'
local push = require 'push'
lg = love.graphics
lk = love.keyboard

-- push
local gameWidth, gameHeight = 800, 600 --fixed game resolution
local windowWidth, windowHeight = 800, 600


function love.load()
  bg = lg.newImage('test.png')
  ssss:init(gameWidth, gameHeight, windowWidth, windowHeight)
end

function love.update(dt)

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
  end
end