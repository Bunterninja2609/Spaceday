local weizen={}
    weizen.x=0
    weizen.y=0
    weizen.body = love.physics.newBody(World,weizen.x,weizen.y, "static")
    weizen.shape = love.physics.newRectangleShape(16,16)
    weizen.fixture = love.physics.newFixture(weizen.body,weizen.shape)
    weizen.wachsTimer =0
    weizen.farbeGruen = 230
    --weizen.farbe = {218/255,165/255,32/255}
function weizen:load()

end

function weizen:update(dt)
    self.wachsTimer = self.wachsTimer+dt
    if self.wachsTimer >= 10 then
        self.farbeGruen =  self.farbeGruen- 230
    end

end

function weizen:draw()
    self.x,self.y = self.body:getPosition( )
    zeichneWeizen(self.wachsTimer,self.x,self.y)
end

function zeichneWeizen(fa,xweizen,yweizen)
     love.graphics.setColor(218/255,fa/10,32/255)
     -- Farbe rot weg machen
     --Farbverlauf
     --love.graphics.setColor(218/255,165/255,32/255)
     love.graphics.rectangle("fill",xweizen,yweizen,16,16)
end

return weizen
