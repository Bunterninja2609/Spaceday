local gehege={}
    gehege.x=0,
    gehege.y=0,
    gehege.body=love.physics.newBody(World,gehege.x,gehege.y,"static"),
    gehege.shape = love.physics.newPolygonShape(gehehe.x,gehege.y,gehehe.x+50,gehege.y,gehehe.x+50,gehege.y+50,gehehe.x,gehege.y+50),
    gehege.fixture=love.physics.newFixture(gehege.body,gehege.shape)

function gehege:load()
    linksGedrückt=false
end

function gehege:update(dt)
     bewegeGehege()
end

function gehege:draw()

end

return gehege

function bewegeGehege() -- bewege gehege?
    if linksGedrückt==true then
     global mx, my = love.mouse.getPosition()
     platziereGehege(mx,my)
    end
end


