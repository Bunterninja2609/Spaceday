local schwein={} 
    schwein.type = "schwein"
    schwein.x=400
    schwein.y=300
    schwein.speed=10
    schwein.direction=math.random()*2*math.pi
    schwein.IsAlive=true
    schweine={}

function schwein:load()
    self.body = love.physics.newBody(World,schwein.x,schwein.y, "dynamic")
    self.shape = love.physics.newCircleShape(16)
    self.fixture = love.physics.newFixture(self.body,self.shape)
end

function schwein:update(dt)
    if self.IsAlive == true then
    self:Schlachten()
    bewegeSchwein(self,self.speed)
    
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

function schwein:Schlachten()
    self.x,self.y = self.body:getPosition()
    local distance = math.sqrt((self.x - spieler.x)^2 + (self.y - spieler.y)^2)
    if distance < 100 and love.keyboard.isDown("e") then
        spieler.inventar.fleisch = spieler.inventar.fleisch + 1
        self.IsAlive = false
    end
end

--function schwein:neuSchwein()
  --  local neuesSchwein = setmetatable({},schweine)
   --  neuesSchwein.x = love.math.random(200,300)
   --  neuesSchwein.y = love.math.random(200,300)
   --  neuesSchwein.speed = 10
   --  neuesSchwein.direction = math.random() * 2 * math.pi
   --  neuesSchwein.isAlive = true
   --  return neuesSchwein
 --end
 

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