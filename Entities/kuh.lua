 local kuh={} 
    kuh.x=0
    kuh.y=0
    kuh.speed=100
    kuh.direction=math.random()*2*math.pi
    kuh.body = love.physics.newBody(World,kuh.x,kuh.y, "dynamic")
    kuh.shape = love.physics.newCircleShape(16)
    kuh.fixture = love.physics.newFixture(kuh.body,kuh.shape)


function kuh.--[[":" nicht "."]]load()
end

function kuh.--[[":" nicht "."]]update(dt)
    bewegeKuh(self.speed)
end

function bewegeKuh(speed,dt)
    local self.direction= math.random()*2*math.pi--self ist nicht definiert
    self.body:applyLinearImpulse(math.cos(self.direction)*speed,math.sin(self.direction)*speed)
end

function kuh.--[[":" nicht "."]]draw()
    local --[[self.]]x, --[[self.]]y = self.body:getPosition( ) --sehr schön
    zeichneKuh(--[[self.]]x,--[[self.]]y,self.shape)
end

function zeichneKuh(xKuh,yKuh,r)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",xKuh,yKuh,r)
end

return kuh

