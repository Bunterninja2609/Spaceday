local gehege={ -- syntax änderung; siehe spieler.lua
    x=0,
    y=0,
    body=love.physics.newBody(World,gehege.x,gehege.y,"static"),
    shape = love.physics.newPolygonShape(gehehe.x,gehege.y,gehehe.x+50,gehege.y,gehehe.x+50,gehege.y+50,gehehe.x,gehege.y+50),
    fixture=love.physics.newFixture(gehege.body,gehege.shape)
}
function gehege.load()

end

function gehege.update(dt)

end

function gehege.draw()

end

return gehege