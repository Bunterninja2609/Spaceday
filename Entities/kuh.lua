 local kuh={} 
    kuh.x=0
    kuh.y=0
    kuh.speed=100
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
    kuh.direction= math.random()*2*math.pi
    kuh.body:applyLinearImpulse(math.cos(kuh.direction)*speed,math.sin(kuh.direction)*speed)
end

function kuh:draw()
    local self.x,self.y = self.body:getPosition( ) --sehr schön
    zeichneKuh(self.x,self.y,self.shape)
end

function zeichneKuh(xKuh,yKuh,r)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",xKuh,yKuh,r)
end

return kuh

