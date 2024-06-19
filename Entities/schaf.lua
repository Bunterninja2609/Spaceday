local schaf={} 
    schaf.type = "schaf"
    schaf.x=400
    schaf.y=300
    schaf.speed=10
    schaf.direction=math.random()*2*math.pi
    schaf.IsAlive=true
    schaf.BekommtWolle=false
    schaf.passiert=false
    schaf.breedTimer = 0
    schaf.timer = 0
    schaf.schafBild = love.graphics.newImage("Textures/schaf 0.png")
    schaf.wolleBild = love.graphics.newImage("Textures/wolle.png")
    schafe={}

function schaf:load()
    self.body = love.physics.newBody(World,self.x,self.y, "dynamic")
    self.shape = love.physics.newCircleShape(16)
    self.fixture = love.physics.newFixture(self.body,self.shape)
end

function schaf:update(dt)
    if self.IsAlive == true then
    self.breedTimer = self.breedTimer + dt
    self:Schlachten()
    self:Wolle(dt)
    bewegeSchafe(self,self.speed)
    self:checkForBreeding(Entitaeten)
    end
end

function bewegeSchafe(schaf,speed,dt)
    local bewegung=false 
    if love.math.random(1,5) == 1 and 2  then 
        bewegung=false
        schaf.body:setLinearVelocity(0,0)
    else
        bewegung=true
        schaf.direction= math.random()*2*math.pi
        schaf.body:applyLinearImpulse(math.cos(schaf.direction)*speed,math.sin(schaf.direction)*speed)
   end
end

function schaf:checkForBreeding(t)
    for i, entity1 in ipairs(t) do
        for j, entity2 in ipairs(t) do
            if entity1.type == "schaf" and entity2.type == "schaf" and entity1.IsAlive and entity2.IsAlive then
                local distance = love.physics.getDistance(entity1.fixture,entity2.fixture)
                if distance < 100 then
                    self:checkObWeizenGegeben(entity1, entity2)
                end
            end
        end
    end
end

function schaf:checkObWeizenGegeben(entity1,entity2)
    local distanceToPlayer1 = love.physics.getDistance(entity1.fixture,spieler.fixture)
    local distanceToPlayer2 = love.physics.getDistance(entity2.fixture,spieler.fixture)
    if distanceToPlayer1 < 100 and distanceToPlayer2 < 100 and love.keyboard.isDown("e") and entity1.breedTimer > 10 and entity2.breedTimer > 10 and spieler.inventar.weizen >= 4 then
        local newX = (entity1.x + entity2.x) / 2 + 20
        local newY = (entity1.y + entity2.y) / 2 + 20
        spawnEntitaet("schaf",newX,newY)
        entity1.breedTimer = 0
        entity2.breedTimer = 0
        spieler.inventar.weizen = spieler.inventar.weizen - 4 
        spieler.xp = spieler.xp + 0.5
    end
end

function schaf:Wolle(dt)
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
     if distance < 80 and love.keyboard.isDown("f") and self.timer < 0.4 then
          self.timer=self.timer+dt
          spieler.inventar.wolle= spieler.inventar.wolle+1
          self.schafBild=love.graphics.newImage("Textures/schaf 1.png")
          self.BekommtWolle=true
        else
            self.BekommtWolle = false
    end
end


function schaf:Schlachten()
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
    if distance < 100 and love.keyboard.isDown("q") then
        spieler.inventar.fleisch = spieler.inventar.fleisch + 1
        spieler.xp = spieler.xp + 0.5
        self.IsAlive = false
    end
end

function schaf:draw()
    if self.IsAlive== true then
    self.x,self.y = self.body:getPosition()
    local xNeu =  self.schafBild:getWidth()
    local yNeu =  self.schafBild:getHeight()
    zeichneSchafe(self.x-xNeu,self.y-yNeu,self.schafBild)
    if self.BekommtWolle== true then 
        zeichneWolle(self.x+10,self.y+10,self.wolleBild)
     end
    end
end

function zeichneWolle(x,y,wolleBild)
    love.graphics.draw(wolleBild,x,y)
end

function zeichneSchafe(x,y,schafBild)
    love.graphics.draw(schafBild,x,y,0,2)
end

return schaf