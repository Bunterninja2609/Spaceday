startscreen = {}
startscreen.x = 0
startscreen.y = 0

function startscreen.load()
    szene = 1 
	start = love.graphics.newImage("Textures/galaxy.jpg")
end

function startscreen.draw()
    if szene == 1 then 
    love.graphics.setColor(1,1,1)
    love.graphics.draw(start,startscreen.x,startscreen.y,0,8)
    end
end

function startscreen.update(dt)
end