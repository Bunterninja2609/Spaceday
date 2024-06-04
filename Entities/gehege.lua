local gehege={}
    --gehege.type = "gehege"
    gehege.x=0
    gehege.y=0
    gehege.body=love.physics.newBody(World,gehege.x,gehege.y,"static")
    gehege.shape = love.physics.newPolygonShape(gehege.x,gehege.y,gehege.x+16,gehege.y,gehege.x+16,gehege.y+16,gehege.x,gehege.y+16)
    gehege.fixture=love.physics.newFixture(gehege.body,gehege.shape)
function gehege:load()
end

function gehege:update(dt)
end

function gehege:draw()
    self.x,self.y = self.body:getPosition()
    zeichneGehege(self.x,self.y,16,16)
end

function zeichneGehege(x,y,w,h)
    love.graphics.setColor(1,1,0)
    love.graphics.rectangle("fill",x,y,w,h)
end

return gehege




