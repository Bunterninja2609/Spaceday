local kuh={} 
    kuh.type = "kuh"
    kuh.x=100
    kuh.y=100
    kuh.speed=10
    kuh.direction=math.random()*2*math.pi
    kuh.isMelking = false
    kuh.kuhBild = love.graphics.newImage("Textures/kuh.png")
    kuh.IsAlive=true
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
     self:Schlachten(dt)
     self:Melken()
    -- self:checkForBreeding()
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

function kuh:Melken()
    self.x,self.y = self.body:getPosition()
    local distance = math.sqrt((self.x- spieler.x)^2 + (self.y - spieler.y)^2)
     if distance < 80 and love.keyboard.isDown("f")then
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
    local distance = math.sqrt((self.x- spieler.x)^2 + (self.y - spieler.y)^2)
     if distance < 80 and love.keyboard.isDown("q") then
        spieler.inventar.fleisch= spieler.inventar.fleisch+1
        self.IsAlive=false
     end
end

function kuh:checkForBreeding(entities)
    for i, entity1 in ipairs(entities) do
        if entity1.type == "kuh" and entity1.IsAlive then
            for j, entity2 in ipairs(entities) do
                if i ~= j and entity2.type == "cow" and entity2.IsAlive then
                 local distance = math.sqrt((entity1.x - entity2.x) ^ 2 + (entity1.y - entity2.y) ^ 2)
                  if distance < 100 then
                    self:checkObWeizenGegeben(entity1, entity2)
                  end
                end
            end
        end
    end

    --der Code muss eher so aussehen, dass du alle ENTITÄTEN durchgehst und überprüfst welche davon eine Kuh ist und welche davon sich vermehren kann.
end

function kuh:checkObWeizenGegeben(cow1, cow2)
    cow1.x,cow1.y = cow1.body:getPosition()
    cow2.x,cow2.y = cow2.body:getPosition()
    local distanceToPlayer1 = math.sqrt((cow1.x - spieler.x) ^ 2 + (cow1.y - spieler.y) ^ 2)
    local distanceToPlayer2 = math.sqrt((cow2.x - spieler.x) ^ 2 + (cow2.y - spieler.y) ^ 2)
    if distanceToPlayer1 < 100 and distanceToPlayer2 < 100 and love.keyboard.isDown("r") then  
        self:neue((cow1.x + cow2.x) / 2 + 20, (cow1.y + cow2.y) / 2 + 20)  
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