local kuh={} 
    kuh.type = "kuh"
    kuh.x=100
    kuh.y=100
    kuh.speed=10
    kuh.direction=math.random()*2*math.pi
    kuh.isMelking = false
    kuh.kuhBild = love.graphics.newImage("Textures/kuh.png")
    kuh.IsAlive=true
    kuh.timer=0
    kuehe={}

   function kuh:neue(x,y)
     local newCow = {
        x = x,
        y = y,
        body = love.physics.newBody(World, x, y, "dynamic"),
        shape = love.physics.newCircleShape(16),
        direction = math.random() * 2 * math.pi,
        isMelking = false,
        IsAlive = true,
        kuhBild = love.graphics.newImage("Textures/kuh.png")
     }
     return newCow 
    end


function kuh:load()
   self.body = love.physics.newBody(World,self.x,self.y, "dynamic")
   self.shape = love.physics.newCircleShape(16)
   self.fixture = love.physics.newFixture(self.body,self.shape)
end

function kuh:update(dt)
    if self.IsAlive== true then
     self:bewegeKuh(self,dt)
     self:Schlachten()
     self:Melken(dt)
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
        zeichneMilch(self.x+30,self.y+30,10)
     end
    end
end

function kuh:Schlachten(dt)
    self.x,self.y = self.body:getPosition()
    local distance = love.physics.getDistance(self.fixture,spieler.fixture)
     if distance < 32 and love.keyboard.isDown("q") then
        spieler.inventar.fleisch= spieler.inventar.fleisch+1
        self.IsAlive=false
     end
end

function kuh:checkForBreeding(Entitaeten)
    for i, entity1 in ipairs(Entitaeten) do
        for j, entity2 in ipairs(Entitaeten) do
            if entity1.type == "kuh" and entity2.type == "kuh" and entity1.IsAlive and entity2.IsAlive then
                local distance = love.physics.getDistance(entity1.fixture,entity2.fixture)
                if distance < 400 then
                    print("JA",300,300)
                    self:checkObWeizenGegeben(entity1, entity2)
                end
            end
        end
    end
end
   

    --!! der Code muss eher so aussehen, dass du alle ENTITÄTEN durchgehst und überprüfst welche davon eine Kuh ist und welche davon sich vermehren kann. !!--


function kuh:checkObWeizenGegeben(entity1,entity2)
    entity1.x,entity1.y = entity1.body:getPosition()
    entity2.x,entity2.y = entity2.body:getPosition()
    local distanceToPlayer1 = love.physics.getDistance(entity1.fixture,spieler.fixture)
    local distanceToPlayer2 = love.physics.getDistance(entity2.fixture,spieler.fixture)
    if distanceToPlayer1 < 50 and distanceToPlayer2 < 50 and love.keyboard.isDown("r") then  
        spawnEntitaet("kuh",(entity1.x + entity2.x) / 2 + 20, (entity1.y + entity2.y) / 2 + 20)  --!! benutze spawnentitaet() !!--
        print("JA",300,300)
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