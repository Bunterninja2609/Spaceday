local gehege={}
    --gehege.type = "gehege"
    gehege.x=0
    gehege.y=0
    
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
end

return gehege




