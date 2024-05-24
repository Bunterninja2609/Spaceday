startscreen = {}
startscreen.x = 400
startscreen.y = 400

function startscreen.load()
    global szene = 1 
	start = love.graphics.newImage("noplan.png")
end

function startscreen.draw()
    if szene == 1 then 
    love.graphics.draw(start,startscreen.x,startscreen.y)
    end
end

function startscreen.update(dt)
end