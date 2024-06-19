local huhn={} 
    huhn.type = "huhn"
    huhn.x=500
    huhn.y=500
    huhn.speed=30 
    huhn.direction=math.random()*2*math.pi
    huhn.ei = false
    huhn.huhnBild = love.graphics.newImage("Textures/huhn.png")
    huhn.eiBild = love.graphics.newImage("Textures/ei.png")
    huhn.IsAlive=true
    huhn.timer=0
    huhn.breedTimer=0 
    huehner={}


function huhn:load()
   self.body = love.physics.newBody(World,self.x,self.y, "dynamic")
   self.shape = love.physics.newCircleShape(16)
   self.fixture = love.physics.newFixture(self.body,self.shape)
end

function huhn:update(dt)
    if self.IsAlive== true then
     self.breedTimer = self.breedTimer + dt
     self:bewegeHuehner(self,dt)
     self:Schlachten()
     self:Eier(dt)
     self:checkForBreeding(Entitaeten)
    end
end

function huhn:bewegeHuehner(huhn,dt)
    local bewegung=false 
    if love.math.random(1,5) == 1 and 2  then 
        bewegung=false
        huhn.body:setLinearVelocity(0,0)
    else
        bewegung=true
        huhn.direction= math.random()*2*math.pi
        huhn.body:applyLinearImpulse(math.cos(huhn.direction)*huhn.speed,math.sin(huhn.direction)*huhn.speed)
   end
end

function huhn:Eier(dt)
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
     if distance < 80 and love.keyboard.isDown("f") and self.timer < 0.4 then
          self.timer=self.timer+dt
          spieler.inventar.ei= spieler.inventar.ei+1
          spieler.xp = spieler.xp + 0.5
          self.ei = true
    else
        self.ei = false
    end
end

function huhn:draw()
    if self.IsAlive== true then
    self.x,self.y = self.body:getPosition()
    local xNeu =  self.huhnBild:getWidth()
    local yNeu =  self.huhnBild:getHeight()
    zeichneHuhn(self.x-xNeu,self.y-yNeu,self.huhnBild)
     if self.ei == true then 
        zeichneEi(self.x+10,self.y+10,self.eiBild)
     end
    end
end

function huhn:Schlachten(dt)
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
     if distance < 32 and love.keyboard.isDown("q") then
        spieler.inventar.fleisch= spieler.inventar.fleisch+1
        spieler.xp = spieler.xp + 0.5
        self.IsAlive=false
     end
end

function huhn:checkForBreeding(t)
    for i, entity1 in ipairs(t) do
        for j, entity2 in ipairs(t) do
            if entity1.type == "huhn" and entity2.type == "huhn" and entity1.IsAlive and entity2.IsAlive then
                local distance = love.physics.getDistance(entity1.fixture,entity2.fixture)
                if distance < 100 then
                    self:checkObWeizenGegeben(entity1, entity2)
                end
            end
        end
    end
end

function huhn:checkObWeizenGegeben(entity1,entity2)
    local distanceToPlayer1 = love.physics.getDistance(entity1.fixture,spieler.fixture)
    local distanceToPlayer2 = love.physics.getDistance(entity2.fixture,spieler.fixture)
    if distanceToPlayer1 < 100 and distanceToPlayer2 < 100 and love.keyboard.isDown("z") and entity1.breedTimer > 10 and entity2.breedTimer > 10 and spieler.inventar.weizen >= 4 then
        local newX = (entity1.x + entity2.x) / 2 + 20
        local newY = (entity1.y + entity2.y) / 2 + 20
        spawnEntitaet("huhn",newX,newY)
        entity1.breedTimer = 0
        entity2.breedTimer = 0
        spieler.inventar.weizen = spieler.inventar.weizen - 4 
        spieler.xp = spieler.xp + 0.5
    end
end


function zeichneEi(x,y,eiBild)
    love.graphics.draw(eiBild,x,y)
end

function zeichneHuhn(x,y,huhnBild)
    love.graphics.draw(huhnBild,x,y,0,2)
end

return huhn