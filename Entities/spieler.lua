local spieler={}
    --spieler.type = "spieler"
    spieler.x=100
    spieler.y=100
    spieler.speed=100
    spieler.direction=1
   

function spieler:load()
    spieler.body = love.physics.newBody(World,spieler.x,spieler.y, "dynamic")
    spieler.shape = love.physics.newCircleShape(16)
    spieler.fixture = love.physics.newFixture(spieler.body,spieler.shape)
    
    spieler.inventar = {
        geld = 0,
        milch = 0,
        fleisch = 0,
        gehege = 0,
        weizen = 0
    }
end

function spieler:update(dt)
 --   self.body:setLinearVelocity(math.cos(self.direction)*self.speed,math.sin(self.direction)*self.speed)
    bewegeSpieler(self.speed,self.body)
end

function spieler:draw()
    self.x,self.y = self.body:getPosition()
    zeichneSpieler(self.x,self.y,15)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Geld: " .. spieler.inventar.geld, 10, 30)
    love.graphics.print("Milch: " .. spieler.inventar.milch, 10, 50)
    love.graphics.print("Fleisch: " .. spieler.inventar.fleisch, 10, 70)
    love.graphics.print("Gehege: " .. spieler.inventar.gehege, 10, 90)
    love.graphics.print("Weizen: " .. spieler.inventar.weizen, 10, 110)
end
function zeichneSpieler(x,y,r)
    love.graphics.setColor(1,1,0)
    love.graphics.circle("fill",x,y,r)
end

function bewegeSpieler(speed,body)
    local speedX = 0
    local speedY = 0 
    if love.keyboard.isDown("w") then
        speedY = -speed
    elseif love.keyboard.isDown("s") then
        speedY = speed
    end
    if love.keyboard.isDown("a") then
        speedX = -speed
    elseif love.keyboard.isDown("d") then
        speedX = speed
    end
    body:setLinearVelocity(speedX,speedY)
end


return spieler
