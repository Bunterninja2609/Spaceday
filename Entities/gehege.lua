local gehege={}
    gehege.x=0
    gehege.y=0
    gehege.body=love.physics.newBody(World,gehege.x,gehege.y,"static")
    gehege.shape = love.physics.newPolygonShape(gehege.x,gehege.y,gehege.x+50,gehege.y,gehege.x+50,gehege.y+50,gehege.x,gehege.y+50)
    gehege.fixture=love.physics.newFixture(gehege.body,gehege.shape)

function gehege:load()
end

function gehege:update(dt)
end

function gehege:draw()
end

return gehege




