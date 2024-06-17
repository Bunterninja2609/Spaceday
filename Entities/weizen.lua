local weizen={} 
    weizen.type = "weizen"
    weizen.x=100
    weizen.y=0
    
    weizen.wachsTimer =0
    weizen.farbeGruen = 205
    weizen.farbeBlau = 50
    weizen.farbeRot = 154

    weizen.distance = 0
    --weizen.farbe = {154/255,205/255,50/255} Anfang
    --weizen.farbe = {218/255,165/255,32/255} Ende

    weizen.weizenBild = love.graphics.newImage("Textures/weizen.png")
   
function weizen:load()
    self.body = love.physics.newBody(World,self.x,self.y, "static")
    self.shape = love.physics.newRectangleShape(16,16)
    self.fixture = love.physics.newFixture(self.body,self.shape)
    self.fixture:setMask(1)
    weizenMinus()
end

function weizen:update(dt)
    self.wachsTimer = self.wachsTimer+dt
    if self.wachsTimer >= 3 then
        if self.farbeGruen >= 165 then
            self.farbeGruen =  self.farbeGruen - 4 * dt 
        end
        if self.farbeBlau >= 32 then
            self.farbeBlau =  self.farbeBlau - 1.8 * dt
        end
        if self.farbeRot <= 218 then
            self.farbeRot = self.farbeRot + 6.4 * dt
        end 
    end
   

    if self.farbeGruen <= 165 then
        self:ernten()
    elseif self.farbeBlau <= 32 then
        self:ernten()
    elseif self.farbeRot >= 218 then
        self:ernten()
    end

    
end

function weizen:draw()
    self.x,self.y = self.body:getPosition( )
    zeichneWeizen(self.farbeRot/256,self.farbeGruen/256,self.farbeBlau/256,self.x,self.y,self.weizenBild) 
    --[[Orientierung
    love.graphics.print(self.farbeGruen,600,300)
    love.graphics.print(self.wachsTimer,600,600)
    love.graphics.print(self.farbeBlau,600,500)
    love.graphics.print(self.farbeRot,600,400)
    love.graphics.print(self.distance,600,700)
    ]]--
end

function zeichneWeizen(fa1,fa2,fa3,xweizen,yweizen,weizenBild)
    love.graphics.setColor(fa1,fa2,fa3)
     love.graphics.draw(weizenBild,xweizen - 16,yweizen - 16,0,2)
     love.graphics.setColor(1,1,1)-- damit der boden nicht übermalt wird
end

function weizen:ernten()
    self.x,self.y = self.body:getPosition()
    self.distance = love.physics.getDistance(spieler.fixture,self.fixture)
    if self.distance < 30 and love.keyboard.isDown("e") then 
        spieler.inventar.weizen = spieler.inventar.weizen+1
        spieler.xp = spieler.xp + 0.5
        self.wachsTimer=0
        self.farbeGruen = 205
        self.farbeBlau = 50
        self.farbeRot = 154
    end

end

function weizenMinus()
    if spieler.inventar.weizen < 0 then
        spieler.inventar.level = spieler.inventar.level-1
    end
end

return weizen
