 local kuh={} 
    kuh.x=300
    kuh.y=300
    kuh.speed=10
    kuh.direction=math.random()*2*math.pi
    kuh.body = love.physics.newBody(World,kuh.x,kuh.y, "dynamic")
    kuh.shape = love.physics.newCircleShape(16)
    kuh.fixture = love.physics.newFixture(kuh.body,kuh.shape)


function kuh:load()
end

function kuh:update(dt)
    bewegeKuh(self,self.speed)
end

function bewegeKuh(kuh,speed,dt)
    local bewegung=false 
    if love.math.random(1,5) == 1  then 
        bewegung=true
        kuh.direction= math.random()*2*math.pi
        kuh.body:applyLinearImpulse(math.cos(kuh.direction)*speed,math.sin(kuh.direction)*speed)
    else
        bewegung=false
        kuh.body:setLinearVelocity(0,0)
   -- kuh.body:applyLinearImpulse(kuh.speed*kuh.direction,kuh.speed*kuh.direction)
   end
end

function kuh:draw()
    self.x,self.y = self.body:getPosition( ) --sehr schön
    zeichneKuh(self.x,self.y,15)
end

function zeichneKuh(xKuh,yKuh,r)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",xKuh,yKuh,r)
end

return kuh

