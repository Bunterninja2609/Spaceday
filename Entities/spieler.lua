local spieler={}
    spieler.x=0,
    spieler.y=0,
    spieler.speed=100,
    spieler.direction=1,
    spieler.body = love.physics.newBody(World,spieler.x,spieler.y, "dynamic"),
    spieler.shape = love.physics.newCircleShape(16),
    spieler.fixture = love.physics.newFixture(spieler.body,spieler.shape)

function spieler.load()
end

function spieler.update(dt)
    self.body:setLinearVelocity(math.cos(self.direction)*self.speed,math.sin(self.direction)*self.speed)
    bewegeSpieler(self.speed)
end

function spieler.draw()
    zeichneSpieler(self.x,self.y,self.shape)
end
function zeichneSpieler(x,y,r) --sehr schön
    love.graphics.setColor(1,1,0)
    love.graphics.circle("fill",x,y,r)
end

function bewegeSpieler(speed) --hier gibt es noch ein problem, ich spreche es in info an.
    if love.keyboard.isDown("w") then
        Body:setLinearVelocity(0,-speed)
    elseif love.keyboard.isDown("s") then
        Body:setLinearVelocity(0,speed)
    end
    if love.keyboard.isDown("a") then
        Body:setLinearVelocity(-speed,0)
    elseif love.keyboard.isDown("d") then
        Body:setLinearVelocity(speed,0)
    end
end
return spieler
