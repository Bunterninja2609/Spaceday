local weizen={} 
    --weizen.type = "weizen"
    weizen.x=0
    weizen.y=0
    weizen.body = love.physics.newBody(World,weizen.x,weizen.y, "static")
    weizen.shape = love.physics.newRectangleShape(16,16)
    weizen.fixture = love.physics.newFixture(weizen.body,weizen.shape)
    weizen.wachsTimer =0
    weizen.farbeGruen = 205
    weizen.farbeBlau = 50
    weizen.farbeRot = 154

    --weizen.farbe = {218/255,165/255,32/255} Ende
    --weizen.farbe = {154/255,205/255,50/255} Anfang
function weizen:load()

end

function weizen:update(dt)
    self.wachsTimer = self.wachsTimer+dt
    if self.wachsTimer >= 10 then
        if self.farbeGruen >= 165 then
        self.farbeGruen =  self.farbeGruen- 4
        end
        if self.farbeBlau >= 32 then
        self.farbeBlau =  self.farbeBlau- 1.8
        end
        if self.farbeRot <= 218 then
        self.farbeRot = self.farbeRot + 6.4
        end
    end

end

function weizen:draw()
    self.x,self.y = self.body:getPosition( )
    zeichneWeizen(self.farbeRot,self.farbeGruen,self.farbeBlau,self.x,self.y)
    --Orientierung
    love.graphics.print(self.farbeGruen,600,300)
    love.graphics.print(self.wachsTimer,600,600)
    love.graphics.print(self.farbeBlau,600,500)
    love.graphics.print(self.farbeRot,600,400)
end

function zeichneWeizen(fa1,fa2,fa3,xweizen,yweizen)
     love.graphics.setColor(fa1,fa2,fa3)
     -- Farbe rot weg machen
     --Farbverlauf
     --love.graphics.setColor(218/255,165/255,32/255)
     love.graphics.rectangle("fill",xweizen,yweizen,16,16)
end

return weizen
