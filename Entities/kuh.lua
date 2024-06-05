local kuh={} 
    kuh.type = "kuh"
    kuh.x=300
    kuh.y=300
    kuh.speed=10
    kuh.direction=math.random()*2*math.pi
    kuh.body = love.physics.newBody(World,kuh.x,kuh.y, "dynamic")
    kuh.shape = love.physics.newCircleShape(16)
    kuh.fixture = love.physics.newFixture(kuh.body,kuh.shape)
    kuh.isMelking = false
    kuh.clickCount=0
    kuh.kuhBild = love.graphics.newImage("Textures/kuh.png")


function kuh:load()
    
end

function kuh:update(dt)
    bewegeKuh(self,self.speed)
end

function bewegeKuh(kuh,speed,dt)
    local bewegung=false 
    if love.math.random(1,5) == 1 and 2  then 
        bewegung=false
        kuh.body:setLinearVelocity(0,0)
    else
        bewegung=true
        kuh.direction= math.random()*2*math.pi
        kuh.body:applyLinearImpulse(math.cos(kuh.direction)*speed,math.sin(kuh.direction)*speed)
   end
end

function kuh:IsClicked(xMouse,yMouse)
    self.x,self.y = self.body:getPosition()
    local distance = math.sqrt((self.x- xMouse)^2 + (self.y - yMouse)^2)
     if distance <= 80 then
        self.isMelking = true
        self.clickCount = self.clickCount + 1 
    else
        self.isMelking = false
    end
end

function kuh:draw()
    self.x,self.y = self.body:getPosition()
    zeichneKuh(self.x,self.y,self.kuhBild)
     if self.isMelking == true then 
        zeichneMilch(self.x+30,self.y+30,10)
        zeigeDieAnzahlAnMilch(self.clickCount,self.x,self.y)
     end
end

function zeigeDieAnzahlAnMilch(clicks,x,y)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Anzahl:"..clicks,x+30,y+50,0,0.7,0.7)
end

function zeichneMilch(x,y,r)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",x,y,r)
end

function zeichneKuh(xKuh,yKuh,kuhBild)
    love.graphics.draw(kuhBild,xKuh,yKuh)
end

return kuh