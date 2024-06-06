local schwein={} 
    schwein.type = "schwein"
    schwein.x=400
    schwein.y=300
    schwein.speed=10
    schwein.direction=math.random()*2*math.pi
   

function schwein:load()
    schwein.body = love.physics.newBody(World,schwein.x,schwein.y, "dynamic")
    schwein.shape = love.physics.newCircleShape(16)
    schwein.fixture = love.physics.newFixture(schwein.body,schwein.shape)
end

function schwein:update(dt)
    --bewegeSchwein(self,self.speed)
end

--[[function bewegeSchwein(schwein,speed,dt)
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

function schwein:IsClicked(xMouse,yMouse)
    self.x,self.y = self.body:getPosition()
    local distance = math.sqrt((self.x- xMouse)^2 + (self.y - yMouse)^2)
     if distance <= 80 then
    end
end
]]--
function schwein:draw()
    self.x,self.y = self.body:getPosition()
    zeichneSchwein(self.x,self.y,16)
end
function zeichneSchwein(x,y,r)
    love.graphics.setColor(1,0.4,0.6)
    love.graphics.circle("fill",x,y,r)
    love.graphics.setColor(1,1,1)
end
return schwein