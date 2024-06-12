spieler={}
    --spieler.type = "spieler"
    spieler.x=300
    spieler.y=300
    spieler.speed=100
    spieler.direction=1
    spieler.spielerBild = love.graphics.newImage("Textures/spieler.png")
    
   
function spieler:load()
    self.body = love.physics.newBody(World,self.x,self.y, "dynamic")
    self.shape = love.physics.newCircleShape(16)
    self.fixture = love.physics.newFixture(self.body,self.shape)
    spieler.inventar = {
        geld = 0,
        milch = 5,
        fleisch = 5,
        gehege = 5,
        weizen = 5
    }
    self.nutzeShop = false
end

function spieler:update(dt)
    bewegeSpieler(self.speed,self.body)
    shopTaste()
end

function spieler:draw()
    self.x,self.y = self.body:getPosition()
    zeichneInventar()
    zeichneShop(1600,50)
    local xNeu =  self.spielerBild:getWidth()
    local yNeu =  self.spielerBild:getHeight()
    zeichneSpieler(self.x-xNeu,self.y-yNeu,self.spielerBild)
end
function zeichneSpieler(x,y,spielerBild)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(spieler.spielerBild,x,y,0,2)
end
function zeichneInventar()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Geld: " .. spieler.inventar.geld, 10, 30)
    love.graphics.print("Milch: " .. spieler.inventar.milch, 10, 50)
    love.graphics.print("Fleisch: " .. spieler.inventar.fleisch, 10, 70)
    love.graphics.print("Gehege: " .. spieler.inventar.gehege, 10, 90)
    love.graphics.print("Weizen: " .. spieler.inventar.weizen, 10, 110)
end
function zeichneShop(x,y)
    if spieler.nutzeShop == true then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", x, y, 400, 100)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Shop:", x+10, y+10)
        love.graphics.print("1. Milch verkaufen (+10 Geld)", x+10, y+30)
        love.graphics.print("2. Fleisch verkaufen (+20 Geld)", x+10, y+50)
        love.graphics.print("3. Weizen verkaufen (+5 Geld)", x+10, y+70)
    end
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
function shopTaste()
    if love.keyboard.isDown("r") then
        spieler.nutzeShop = true
    else
        spieler.nutzeShop = false
    end
end
return spieler
