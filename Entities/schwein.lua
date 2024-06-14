local schwein={} 
    schwein.type = "schwein"
    schwein.x=400
    schwein.y=300
    schwein.speed=10
    schwein.direction=math.random()*2*math.pi
    schwein.IsAlive=true
    schweine={}

function schwein:load()
    self.body = love.physics.newBody(World,self.x,self.y, "dynamic")
    self.shape = love.physics.newCircleShape(16)
    self.fixture = love.physics.newFixture(self.body,self.shape)
end

function schwein:neue(x,y)
    local neuSchwein = {
         x = x,
         y = y,
         body = love.physics.newBody(World, x, y, "dynamic"),
         shape = love.physics.newCircleShape(16),
         direction = math.random() * 2 * math.pi,
       }
       -- Insert new cow into the cows table
       table.insert(schweine,neuSchwein)
   end
function schwein:update(dt)
    if self.IsAlive == true then
    self:Schlachten()
    bewegeSchwein(self,self.speed)
   -- self:checkForBreeding(Entitaeten)
    
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

function schwein:checkForBreeding(Entitaeten)
    for i, entity1 in ipairs(Entitaeten) do
        for j, entity2 in ipairs(Entitaeten) do
            if entity1.type == "schwein" and entity2.type == "schwein" and entity1.IsAlive and entity2.IsAlive then
                local distance = love.physics.getDistance(entity1.fixture,entity2.fixture)
                if distance < 400 then
                    print("JA",300,300)
                    self:checkObWeizenGegeben(entity1, entity2)
                end
            end
        end
    end
end

function schwein:checkObWeizenGegeben(entity1,entity2)
    local distanceToPlayer1 = love.physics.getDistance(entity1.fixture,spieler.fixture)
    local distanceToPlayer2 = love.physics.getDistance(entity2.fixture,spieler.fixture)
    if distanceToPlayer1 < 50 and distanceToPlayer2 < 50 and love.keyboard.isDown("r") then  
        spawnEntitaet("schwein",(entity1.x + entity2.x) / 2 + 20, (entity1.y + entity2.y) / 2 + 20) 
        print("JA",300,300)
    end
end

function schwein:Schlachten()
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
    if distance < 100 and love.keyboard.isDown("q") then
        spieler.inventar.fleisch = spieler.inventar.fleisch + 1
        self.IsAlive = false
    end
end

function schwein:draw()
    if self.IsAlive== true then
    self.x,self.y = self.body:getPosition()
    zeichneSchwein(self.x,self.y,16)
    end
end

function zeichneSchwein(x,y,r)
    love.graphics.setColor(1,0.4,0.6)
    love.graphics.circle("fill",x,y,r)
    love.graphics.setColor(1,1,1)--damit Boden nicht übermalt wird
end

return schwein