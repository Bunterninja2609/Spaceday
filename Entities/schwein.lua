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
    self:checkForBreeding()
    
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

function schwein:checkForBreeding()
    for i, schwein1 in ipairs(schweine) do
        for j, schwein2 in ipairs(schweine) do
            if i ~= j and schwein1.IsAlive and schwein2.IsAlive then
                local distance = math.sqrt((schwein1.x - schwein2.x) ^ 2 + (schwein1.y - schwein2.y) ^ 2)
                if distance < 100 then
                    self:checkObWeizenGegeben(schwein1, schwein2)
                end
            end
        end
    end
end

function schwein:checkObWeizenGegeben(schwein1,schwein2)
    schwein1.x,schwein1.y = schwein1.body:getPosition()
    schwein2.x,schwein2.y = schwein2.body:getPosition()
    local distanceToPlayer1 = math.sqrt((schwein1.x - spieler.x) ^ 2 + (schwein1.y - spieler.y) ^ 2)
    local distanceToPlayer2 = math.sqrt((schwein2.x - spieler.x) ^ 2 + (schwein2.y - spieler.y) ^ 2)
    if distanceToPlayer1 < 100 and distanceToPlayer2 < 100 and love.keyboard.isDown("r") then  
        self:neue((schwein1.x + schwein2.x) / 2 + 20, (schwein1.y + schwein2.y) / 2 + 20)  
    end
end

function schwein:Schlachten()
    self.x,self.y = self.body:getPosition()
    local distance = math.sqrt((self.x - spieler.x)^2 + (self.y - spieler.y)^2)
    if distance < 100 and love.keyboard.isDown("e") then
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