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
        ei = 0,
        wolle = 0,
        gehege = 20,
        weizen = 20,
        level = 0
    }
    spieler.xp = 0
    self.nutzeShop = false
    kaufButtons = {}
    verkaufButtons ={}
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
    love.graphics.setColor(1, 1, 0)
    love.graphics.print("Geld: " .. spieler.inventar.geld, 10, 30)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Weizen: " .. spieler.inventar.weizen, 10, 50)
    love.graphics.print("Gehege: " .. spieler.inventar.gehege, 10, 70)
    if spieler.inventar.level < 1 then 
        love.graphics.setColor(0.5,0.5,0.5)
    end
    love.graphics.print("Milch: " .. spieler.inventar.milch, 10, 90)
    love.graphics.print("Fleisch: " .. spieler.inventar.fleisch, 10, 110)
    if spieler.inventar.level < 3 then 
        love.graphics.setColor(0.5,0.5,0.5)
    end
    love.graphics.print("Wolle: " .. spieler.inventar.wolle, 10, 130)
    if spieler.inventar.level < 4 then 
        love.graphics.setColor(0.5,0.5,0.5)
    end
    love.graphics.print("Eier: " .. spieler.inventar.ei, 10, 150)
    love.graphics.setColor(1, 0, 0)
    love.graphics.print("Level: " .. spieler.inventar.level, 10, 170)
end
function zeichneShop(x,y)
    kaufButtons = {} 
    verkaufButtons = {}
    if spieler.nutzeShop == true then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", x, y, 500, 150)
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line", x, y, 500, 150)
        love.graphics.setColor(1, 1, 1)

        love.graphics.setColor(1,1,0)  
        love.graphics.print("Verkaufen", x+10, y+10)
        love.graphics.setColor(1, 1, 1)
            love.graphics.print("Weizen (+7 Geld)", x+10, y+30)
            zeichneVerkaufButton(x,y+30,verkaufeWeizen)
            if spieler.inventar.level >= 1 then
                love.graphics.print("Milch (+10 Geld)", x+10, y+50)
                zeichneVerkaufButton(x,y+50,verkaufeMilch)
                love.graphics.print("Fleisch (+20 Geld)", x+10, y+70)
                zeichneVerkaufButton(x,y+70,verkaufeFleisch)
            end
            if spieler.inventar.level >= 3 then
                love.graphics.print("Wolle (+15 Geld)", x+10, y+90)
                zeichneVerkaufButton(x,y+90,verkaufeWolle)
            end
            if spieler.inventar.level >= 4 then
                love.graphics.print("Ei (+15 Geld)", x+10, y+110)
                zeichneVerkaufButton(x,y+110,verkaufeEi)
            end

        love.graphics.setColor(1,1,0)  
        love.graphics.print("Kaufen", x+250, y+10)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Weizen (-5 Geld)", x+250, y+30)
            zeichneKaufButton(x,y+30,kaufeWeizen)
            love.graphics.print("Gehege (-5 Geld)", x+250, y+50)
            zeichneKaufButton(x,y+50,kaufeGehege)
            if spieler.inventar.level >= 1 then
                love.graphics.print("Kuh (-50 Geld)", x+250, y+70)
                zeichneKaufButton(x,y+70,kaufeKuh)
            end
            if spieler.inventar.level >= 2 then
                love.graphics.print("Schwein (-30 Geld)", x+250, y+90)
                zeichneKaufButton(x,y+90,kaufeSchwein)
            end
            if spieler.inventar.level >= 3 then
                love.graphics.print("Schaf (-70 Geld)", x+250, y+110)
                zeichneKaufButton(x,y+110,kaufeSchaf)
            end
            if spieler.inventar.level >= 4 then
                love.graphics.print("Huhn (-80 Geld)", x+250, y+130)
                zeichneKaufButton(x,y+130,kaufeHuhn)
            end
    end
end
function zeichneKaufButton(x, y, action)
    table.insert(kaufButtons, {x = x + 450, y = y, width = 25, height = 15, action = action})
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", x + 450, y, 25, 15)
    love.graphics.setColor(0.4, 0, 0)
    love.graphics.rectangle("line", x + 450, y, 25, 15)
    love.graphics.print("+1", x + 450, y)
    love.graphics.setColor(1, 1, 1)
end

function zeichneVerkaufButton(x, y, action)
    table.insert(verkaufButtons, {x = x + 200, y = y, width = 25, height = 15, action = action})
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", x + 200, y, 25, 15)
    love.graphics.setColor(0, 0.4, 0)
    love.graphics.rectangle("line", x + 200, y, 25, 15)
    love.graphics.print("-1", x + 200, y)
    love.graphics.setColor(1, 1, 1)
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
    if love.keyboard.isDown("k") then
        spieler.nutzeShop = true
    else
        spieler.nutzeShop = false
    end
end

function zeichneLevel(w)
    if spieler.inventar.level==0 then
      love.graphics.setColor(1,0,0)
      love.graphics.rectangle("fill",10,190,w/50*200,10)
      love.graphics.print("XP:".. spieler.xp .. "/50",10,210)
    end
    if spieler.inventar.level==1 then
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill",10,190,w/250*200,10)
        love.graphics.print("XP:".. spieler.xp .. "/250",10,210)
      end
    if spieler.inventar.level==2  then
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill",10,190,w/500*200,10)
        love.graphics.print("XP:".. spieler.xp .. "/500",10,210)
    end
    if spieler.inventar.level==3 then
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill",10,190,w/1000*200,10)
        love.graphics.print("XP:".. spieler.xp .. "/1000",10,210)
    end
    if spieler.inventar.level==4  then
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill",10,190,w/1500*200,10)
        love.graphics.print("XP:".. spieler.xp .. "/1500",10,210)
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
    if spieler.xp> 1000 and spieler.inventar.level==3 then
        spieler.inventar.level = spieler.inventar.level+1
        spieler.xp = 0
        for i = 0, 3 do
            spawnEntitaet("huhn", 500, 300)
         end
    end
end
return spieler
