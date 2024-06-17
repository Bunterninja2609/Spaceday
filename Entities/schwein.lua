local schwein={} 
    schwein.type = "schwein"
    schwein.x=500
    schwein.y=500
    schwein.speed=10
    schwein.direction=math.random()*2*math.pi
    schwein.IsAlive=true
    schwein.breedTimer=0
    schwein.schweinBild = love.graphics.newImage("Textures/schwein.png")
    schweine={}

function schwein:load()
    self.body = love.physics.newBody(World,self.x,self.y, "dynamic")
    self.shape = love.physics.newCircleShape(16)
    self.fixture = love.physics.newFixture(self.body,self.shape)
end

function schwein:update(dt)
    if self.IsAlive == true then
    self.breedTimer = self.breedTimer + dt
    self:Schlachten()
    bewegeSchwein(self,self.speed)
    self:checkForBreeding(Entitaeten)
    end
end

function bewegeSchwein(schwein,speed,dt)
    local bewegung=false 
    if love.math.random(1,5) == 1 and 2  then 
        bewegung=false
        schwein.body:setLinearVelocity(0,0)
    else
        bewegung=true
        schwein.direction= math.random()*2*math.pi
        schwein.body:applyLinearImpulse(math.cos(schwein.direction)*speed,math.sin(schwein.direction)*speed)
   end
end

function schwein:checkForBreeding(t)
    for i, entity1 in ipairs(t) do
        for j, entity2 in ipairs(t) do
            if entity1.type == "schwein" and entity2.type == "schwein" and entity1.IsAlive and entity2.IsAlive then
                local distance = love.physics.getDistance(entity1.fixture,entity2.fixture)
                if distance < 100 then
                    self:checkObWeizenGegeben(entity1, entity2)
                end
            end
        end
    end
end

function schwein:checkObWeizenGegeben(entity1,entity2)
    local distanceToPlayer1 = love.physics.getDistance(entity1.fixture,spieler.fixture)
    local distanceToPlayer2 = love.physics.getDistance(entity2.fixture,spieler.fixture)
    if distanceToPlayer1 < 100 and distanceToPlayer2 < 100 and love.keyboard.isDown("e") and entity1.breedTimer > 10 and entity2.breedTimer > 10 and spieler.inventar.weizen >= 4 then
        local newX = (entity1.x + entity2.x) / 2 + 20
        local newY = (entity1.y + entity2.y) / 2 + 20
        spawnEntitaet("schwein",newX,newY)
        entity1.breedTimer = 0
        entity2.breedTimer = 0
        spieler.inventar.weizen = spieler.inventar.weizen - 4 --!!es kostet weizen !!--
        spieler.xp = spieler.xp + 0.5
    end
end

function schwein:Schlachten()
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
    if distance < 100 and love.keyboard.isDown("q") then
        spieler.inventar.fleisch = spieler.inventar.fleisch + 1
        spieler.xp = spieler.xp + 0.5
        self.IsAlive = false
    end
end

function schwein:draw()
    if self.IsAlive== true then
    self.x,self.y = self.body:getPosition()
    local xNeu =  self.schweinBild:getWidth()
    local yNeu =  self.schweinBild:getHeight()
    zeichneKuh(self.x-xNeu,self.y-yNeu,self.schweinBild)
    end
end

return schwein