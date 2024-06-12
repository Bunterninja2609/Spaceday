local gehege={}
gehege.type = "gehege"
    gehege.IsAlive=true
    gehege.x=0
    gehege.y=0
    gehege.body=love.physics.newBody(World,gehege.x,gehege.y,"static")
    gehege.shape = love.physics.newPolygonShape(gehege.x,gehege.y,gehege.x+50,gehege.y,gehege.x+50,gehege.y+50,gehege.x,gehege.y+50)
    gehege.fixture=love.physics.newFixture(gehege.body,gehege.shape)

function gehege:load()
    self.body=love.physics.newBody(World,self.x,self.y,"static")
    self.shape = love.physics.newRectangleShape(16, 16)
    self.fixture=love.physics.newFixture(self.body,self.shape)
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
    love.graphics.setColor(1,1,1)-- damit der boden nicht übermalt wird
end

return gehege




