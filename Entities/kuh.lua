local kuh={} 
    kuh.type = "kuh"
    kuh.x=100
    kuh.y=100
    kuh.speed=10
    kuh.direction=math.random()*2*math.pi
    kuh.isMelking = false
    kuh.kuhBild = love.graphics.newImage("Textures/kuh.png")
    

function kuh:load()
   self.body = love.physics.newBody(World,kuh.x,kuh.y, "dynamic")
   self.shape = love.physics.newCircleShape(16)
   self.fixture = love.physics.newFixture(self.body,self.shape)
end

function kuh:update(dt)
     bewegeKuh(self,self.body,self.speed)
   -- self:Schlachten()
end

function bewegeKuh(kuh,kuhBody,speed,dt)
    local bewegung=false 
    if love.math.random(1,5) == 1 and 2  then 
        bewegung=false
        kuhBody:setLinearVelocity(0,0)
    else
        bewegung=true
        kuh.direction= math.random()*2*math.pi
        kuhBody:applyLinearImpulse(math.cos(kuh.direction)*speed,math.sin(kuh.direction)*speed)
   end
end

function kuh:IsClickedMilch(xMouse,yMouse)
    self.x,self.y = self.body:getPosition()
    local distance = math.sqrt((self.x- xMouse)^2 + (self.y - yMouse)^2)
     if distance <= 80 then
        self.isMelking = true
        spieler.inventar.milch= spieler.inventar.milch+1
    else
        self.isMelking = false
    end
end

function kuh:Schlachten()
    self.x,self.y = self.body:getPosition()
    local distance = math.sqrt((self.x- spieler.x)^2 + (self.y - spieler.y)^2)
     if distance <= 80 then
        if love.keyboard.isDown("q") then
         --self.body:destroy()
         spieler.inventar.fleisch= spieler.inventar.fleisch+1
        end
     end
end


function kuh:draw()
    self.x,self.y = self.body:getPosition()
    local xNeu =  self.kuhBild:getWidth()
    local yNeu =  self.kuhBild:getHeight()
    love.graphics.print(self.x,300,300)
    zeichneKuh(self.x-xNeu,self.y-yNeu,self.kuhBild)
     if self.isMelking == true then 
        zeichneMilch(self.x+30,self.y+30,10)
     end
end

function zeichneMilch(x,y,r)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",x,y,r)
end

function zeichneKuh(xKuh,yKuh,kuhBild)
    love.graphics.draw(kuhBild,xKuh,yKuh,0,2)
end

return kuh