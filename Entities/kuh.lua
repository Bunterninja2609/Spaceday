local kuh={} 
    kuh.type = "kuh"
    kuh.x=500
    kuh.y=500
    kuh.speed=30 
    kuh.direction=math.random()*2*math.pi
    kuh.isMelking = false
    kuh.kuhBild = love.graphics.newImage("Textures/kuh.png")
    kuh.milchBild = love.graphics.newImage("Textures/milch.png")
    kuh.IsAlive=true
    kuh.timer=0
    kuh.breedTimer=0 
    kuehe={}


function kuh:load()
   self.body = love.physics.newBody(World,self.x,self.y, "dynamic")
   self.shape = love.physics.newCircleShape(16)
   self.fixture = love.physics.newFixture(self.body,self.shape)
end

function kuh:update(dt)
    if self.IsAlive== true then
     self.breedTimer = self.breedTimer + dt
     self:bewegeKuh(self,dt)
     self:Schlachten()
     self:Melken(dt)
     self:checkForBreeding(Entitaeten)
    end
end

function kuh:bewegeKuh(kuh,dt)
    local bewegung=false 
    if love.math.random(1,5) == 1 and 2  then 
        bewegung=false
        kuh.body:setLinearVelocity(0,0)
    else
        bewegung=true
        kuh.direction= math.random()*2*math.pi
        kuh.body:applyLinearImpulse(math.cos(kuh.direction)*kuh.speed,math.sin(kuh.direction)*kuh.speed)
   end
end

function kuh:Melken(dt)
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
     if distance < 80 and love.keyboard.isDown("f") and self.timer < 0.4 then
          self.timer=self.timer+dt
          spieler.inventar.milch= spieler.inventar.milch+1
          spieler.xp = spieler.xp + 0.5
          self.isMelking = true
    else
        self.isMelking = false
    end
end

function kuh:draw()
    if self.IsAlive== true then
    self.x,self.y = self.body:getPosition()
    local xNeu =  self.kuhBild:getWidth()
    local yNeu =  self.kuhBild:getHeight()
    zeichneKuh(self.x-xNeu,self.y-yNeu,self.kuhBild)
     if self.isMelking == true then 
        zeichneMilch(self.x+10,self.y+10,self.milchBild)
     end
    end
end

function kuh:Schlachten(dt)
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
     if distance < 32 and love.keyboard.isDown("q") then
        spieler.inventar.fleisch= spieler.inventar.fleisch+1
        spieler.xp = spieler.xp + 0.5
        self.IsAlive=false
     end
end

function kuh:checkForBreeding(t)
    for i, entity1 in ipairs(t) do
        for j, entity2 in ipairs(t) do
            if entity1.type == "kuh" and entity2.type == "kuh" and entity1.IsAlive and entity2.IsAlive then
                local distance = love.physics.getDistance(entity1.fixture,entity2.fixture)
                if distance < 100 then
                    self:checkObWeizenGegeben(entity1, entity2)
                end
            end
        end
    end
end

function kuh:checkObWeizenGegeben(entity1,entity2)
    local distanceToPlayer1 = love.physics.getDistance(entity1.fixture,spieler.fixture)
    local distanceToPlayer2 = love.physics.getDistance(entity2.fixture,spieler.fixture)
    if distanceToPlayer1 < 100 and distanceToPlayer2 < 100 and love.keyboard.isDown("z") and entity1.breedTimer > 10 and entity2.breedTimer > 10 and spieler.inventar.weizen >= 4 then
        local newX = (entity1.x + entity2.x) / 2 + 20
        local newY = (entity1.y + entity2.y) / 2 + 20
        spawnEntitaet("kuh",newX,newY)
        entity1.breedTimer = 0
        entity2.breedTimer = 0
        spieler.inventar.weizen = spieler.inventar.weizen - 4 
        spieler.xp = spieler.xp + 0.5
    end
end


function zeichneMilch(x,y,milchBild)
    love.graphics.draw(milchBild,x,y)
end

function zeichneKuh(xKuh,yKuh,kuhBild)
    love.graphics.draw(kuhBild,xKuh,yKuh,0,2)
end

return kuh