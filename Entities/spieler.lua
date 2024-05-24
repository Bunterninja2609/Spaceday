local spieler={}
    spieler.x=0,
    spieler.y=0,
    spieler.speed=100,
    spieler.direction=1,
    spieler.body = love.physics.newBody(World,spieler.x,spieler.y, "dynamic"),
    spieler.shape = love.physics.newCircleShape(16),
    spieler.fixture = love.physics.newFixture(spieler.body,spieler.shape)

function spieler.--[[":" nicht "."]]load()
end

function spieler.--[[":" nicht "."]]update(dt)
    self.body:setLinearVelocity(math.cos(self.direction)*self.speed,math.sin(self.direction)*self.speed)
    bewegeSpieler(self.speed)
end

function spieler.--[[":" nicht "."]]draw()
    zeichneSpieler(self.x,self.y,self.shape)
end
function zeichneSpieler(x,y,r)
    love.graphics.setColor(1,1,0)
    love.graphics.circle("fill",x,y,r)
end

function bewegeSpieler(speed)
    if love.keyboard.isDown("w") then
        Body:setLinearVelocity(0,-speed) -- Body ist nicht definiert
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
