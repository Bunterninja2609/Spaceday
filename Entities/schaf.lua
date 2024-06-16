local schaf={} 
    schaf.type = "schaf"
    schaf.x=400
    schaf.y=300
    schaf.speed=10
    schaf.direction=math.random()*2*math.pi
    schaf.IsAlive=true
    schaf.passiert=false
    schaf.breedTimer=0
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
        spieler.inventar.weizen = spieler.inventar.weizen - 4 --!!es kostet weizen !!--
    end
end




function schaf:Schlachten()
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
    if distance < 100 and love.keyboard.isDown("q") then
        spieler.inventar.fleisch = spieler.inventar.fleisch + 1
        self.IsAlive = false
    end
end

function schaf:draw()
    if self.IsAlive== true then
    self.x,self.y = self.body:getPosition()
    zeichneSchafe(self.x,self.y,16)
    end
end

function zeichneSchafe(x,y,r)
    love.graphics.setColor(0.8,0.8,0.8)
    love.graphics.circle("fill",x,y,r)
    love.graphics.setColor(1,1,1)--damit Boden nicht übermalt wird
end

return schaf