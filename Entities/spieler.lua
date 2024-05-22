local spieler={
    x=0,
    y=0,
    speed=100,
    direction=1,
    body = love.physics.newBody(World,spieler.x,spieler.y, "dynamic"),
    shape = love.physics.newCircleShape(16),
    fixture = love.physics.newFixture(spieler.body,spieler.shape)
}

function spieler.load()
end

function spieler.update(dt)
spieler.body:applyLinearImpulse(math.cos(spieler.direction)*spieler.speed,math.sin(spieler.direction)*spieler.speed)
spieler.body:setLinearVelocity(math.cos(spieler.direction)*spieler.speed,math.sin(spieler.direction)*spieler.speed)
    bewegeSpieler(spieler.x,spieler.y,spieler.speed)
end

function spieler.draw()
 zeichneSpieler(spieler.x,spieler.y,spieler.shape)
end
function zeichneSpieler(x,y,r)
    love.graphics.setColor(1,1,0)
    love.graphics.circle("fill",x,yK,r)
end

function bewegeSpieler(x,y,speed,dt)
    if love.keyboard.isDown("w") then
        y = y-speed*dt
    elseif love.keyboard.isDown("s") then
        y = y+speed*dt
    end
    if love.keyboard.isDown("a") then
        x = x-speed*dt
    elseif love.keyboard.isDown("d") then
        x = x+speeed*dt
    end
end
return spieler
