spieler={}
    --spieler.type = "spieler"
    spieler.x=300
    spieler.y=300
    spieler.speed=100
    spieler.direction=1
    spieler.spielerBild = love.graphics.newImage("Textures/spielerS.png")
    
    
   
function spieler:load()
    self.body = love.physics.newBody(World,self.x,self.y, "dynamic")
    self.shape = love.physics.newCircleShape(16)
    spieler.fixture = love.physics.newFixture(self.body,self.shape)
    spieler.inventar = {
        geld = 0,
        milch = 0,
        fleisch = 0,
        wolle = 0,
        gehege = 20,
        weizen = 20,
        level = 0
    }
    spieler.xp = 0
    self.nutzeShop = false
end

function spieler:update(dt)
    bewegeSpieler(self.speed,self.body)
    shopTaste()
    level()
    camera.follow(self.body:getX(), self.body:getY(), true)
end

function spieler:draw()
    self.x,self.y = self.body:getPosition()
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
    love.graphics.print("Wolle: " .. spieler.inventar.wolle, 10, 90)
    love.graphics.print("Gehege: " .. spieler.inventar.gehege, 10, 110)
    love.graphics.print("Weizen: " .. spieler.inventar.weizen, 10, 130)
    love.graphics.print("Level: " .. spieler.inventar.level, 10, 150)
end
function zeichneShop(x,y)
    if spieler.nutzeShop == true then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", x, y, 400, 100)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Shop:", x+10, y+10)
        love.graphics.print("1. Milch verkaufen (+10 Geld)", x+10, y+30)
        love.graphics.print("2. Fleisch verkaufen (+20 Geld)", x+10, y+50)
        love.graphics.print("4. Weizen verkaufen (+5 Geld)", x+10, y+70)
    end
end

function bewegeSpieler(speed,body)
    local speedX = 0
    local speedY = 0 
    if love.keyboard.isDown("w") then
        speedY = -speed
        spieler.spielerBild = love.graphics.newImage("Textures/spielerW.png")
    elseif love.keyboard.isDown("s") then
        speedY = speed
        spieler.spielerBild = love.graphics.newImage("Textures/spielerS.png")
    end
    if love.keyboard.isDown("a") then
        speedX = -speed
        spieler.spielerBild = love.graphics.newImage("Textures/spielerA.png")
    elseif love.keyboard.isDown("d") then
        speedX = speed
        spieler.spielerBild = love.graphics.newImage("Textures/spielerD.png")
    end
    body:setLinearVelocity(speedX,speedY)
end
function shopTaste()
    if love.keyboard.isDown("g") then
        spieler.nutzeShop = true
    else
        spieler.nutzeShop = false
    end
end

function zeichneLevel(w)
    if spieler.inventar.level==0 then
      love.graphics.setColor(1,0,0)
      love.graphics.rectangle("fill",10,170,w,10)
      love.graphics.print("XP:".. spieler.xp .. "/50",10,190)
    end
    if spieler.inventar.level==1 then
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill",10,170,w,10)
        love.graphics.print("XP:".. spieler.xp .. "/250",10,190)
      end
    if spieler.inventar.level==2  then
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill",10,170,w,10)
        love.graphics.print("XP:".. spieler.xp .. "/500",10,190)
    end
end

function level()
    
    if spieler.xp> 50 and spieler.inventar.level == 0 then
        spieler.inventar.level = spieler.inventar.level+1
        spieler.xp = 0
        for i = 0, 3 do
            spawnEntitaet("kuh", 500, 300)
         end
    end
    if spieler.xp> 250 and spieler.inventar.level==1 then
        spieler.inventar.level = spieler.inventar.level+1
        spieler.xp = 0
        for i = 0, 3 do
            spawnEntitaet("schwein", 500, 300)
         end
    end
    if spieler.xp> 500 and spieler.inventar.level==2 then
        spieler.inventar.level = spieler.inventar.level+1
        spieler.xp = 0
        for i = 0, 3 do
            spawnEntitaet("schaf", 500, 300)
         end
    end
end
return spieler
