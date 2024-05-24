local startscreen {}
startscreen.x = 400
startscreen.y = 400

function startscreen:load()
	start = love.graphics.newImage("noplan.png")
end

function startscreen:draw()
    love.graphics.draw(start,startscreen.x,startscreen.y)
end

function startscreen: update(dt)
end