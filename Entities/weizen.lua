local weizen={}
    weizen.x=0
    weizen.y=0
    weizen.body = love.physics.newBody(World,weizen.x,weizen.y, "static")
    weizen.shape = love.physics.newRectangleShape(16,16)
    weizen.fixture = love.physics.newFixture(weizen.body,weizen.shape)

function weizen:load()

end

function weizen:update(dt)

end

function weizen:draw()
    self.x,self.y = self.body:getPosition( )
    zeichneWeizen(self.x,self.y)
end

function zeichneWeizen(xweizen,yweizen)
     love.graphics.setColor(218/255,165/255,32/255)
     love.graphics.rectangle("fill",xweizen,yweizen,16,16)
end

return weizen