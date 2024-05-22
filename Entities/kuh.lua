 local kuh={
    x=0,
    y=0,
    speed=100,
    direction=1,
    body = love.physics.newBody(World,kuh.x,kuh.y, "dynamic"),
    shape = love.physics.newCircleShape(16),
    fixture = love.physics.newFixture(kuh.body,kuh.shape)
}

function kuh.load()
end

function kuh.update(dt)
    self.body:applyLinearImpulse(math.cos(self.direction)*self.speed,math.sin(self.direction)*self.speed)
end

function kuh.draw()
    zeichneKuh(self.x,self.y,self.shape)
end

function zeichneKuh(xKuh,yKuh,r)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",xKuh,yKuh,r)
end
return kuh

