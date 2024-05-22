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
    bewegeSpieler(self.x,self.y,self.speed)
end

function spieler.draw()
    zeichneSpieler(self.x,self.y,self.shape)
end
function zeichneSpieler(x,y,r) --sehr schön
    love.graphics.setColor(1,1,0)
    love.graphics.circle("fill",x,y,r)
end

function bewegeSpieler(x,y,speed,dt) --hier gibt es noch ein problem, ich spreche es in info an.
    if love.keyboard.isDown("w") then
        y = y-speed*dt                 --setLinearvelocity!
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
