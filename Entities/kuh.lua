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
    self.body:applyLinearImpulse(math.cos(kuh.direction)*kuh.speed,math.sin(kuh.direction)*kuh.speed)
    self.body:setLinearVelocity(math.cos(kuh.direction)*kuh.speed,math.sin(kuh.direction)*kuh.speed)--applyLinearImpulse UND setLinearVelocity gleichzeitig macht keinen sinn

end

function kuh.draw()
    zeichneKuh(kuh.x,kuh.y,kuh.shape)
end

function zeichneKuh(xKuh,yKuh,r)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",xKuh,yKuh,r)
end
return kuh

