require "startscreen"
require "Libraries/camera"
function love.load()
    love.graphics.setDefaultFilter("nearest","nearest")
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
    --[[for i = 0, 3 do
      spawnEntitaet("kuh", 500, 300)
    end
    spawnEntitaet("gehege")
   
    --spawnEntitaet("weizen")
    for i =0, 3 do
        spawnEntitaet("schwein",600,300)
    end
    for i =0,3 do
         spawnEntitaet("schaf",400,400)
         spawnEntitaet("huhn",400,400)
    end ]]--
    spawnEntitaet("spieler", 500, 50)
    startscreen.load()
    zeit=0
    soundTimer = {
        { sound = nil, timer = 0, interval = 15 },
        { sound = nil, timer = 0, interval = 20 },
        { sound = nil, timer = 0, interval = 25 }
    }
    soundTimer[1].sound = love.audio.newSource("Textures/kuhSound.mp3", "static")
    soundTimer[2].sound = love.audio.newSource("Textures/schafSound.mp3", "static")
    soundTimer[3].sound = love.audio.newSource("Textures/schweinSound.mp3", "static")
    geldSound=love.audio.newSource("Textures/geldSound.mp3","static")
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
end

function love.draw()
    camera.init()
    boden()
    table.sort(Entitaeten, function(a, b) return a.body:getY() < b.body:getY() end) --!!diese Funktion sorgt dafür, dass die Entitaeten weiter hinten zuerst gezeichnet werden!!--
    for i,v in ipairs(Entitaeten) do
        v:draw()
    end
    camera.exit()
    startscreen.draw()
    love.graphics.setBackgroundColor(58/255, 68/255, 102/255)
    love.graphics.setFont(love.graphics.newFont("font.ttf"))   
    zeichneInfo(screenWidth-70,30)
    zeichneInventar() 
    zeichneLevel(spieler.xp)
    zeichneShop(screenWidth-550,50)
    startscreen.draw()
    love.graphics.setFont(love.graphics.newFont("font.ttf"))  
end


function love.update(dt)
    removeDeadEntities(Entitaeten)
    for i,v in ipairs(Entitaeten) do 
        if v.type=="kuh" or v.type=="schwein"then
          -- v:checkForBreeding(Entitaeten)
        end
        v:update(dt) 
        screenNichtVerlassen(v)
    end
         World:update(dt)
         infoZeit(dt)
         audioAbspielen(dt)
end

function spawnEntitaet(typ, x, y) 
    local vorlageEntitaet=require("Entities/"..typ)
    local entitaet={}
    for key,value in pairs(vorlageEntitaet) do
     entitaet[key]=value
    end
    entitaet.x, entitaet.y = x, y 
    entitaet:load()
    table.insert(Entitaeten,entitaet)
end

function platziereGehege(x,y)
    local canPlace = true

    for i,v in ipairs(Entitaeten) do 
        if v.type== "weizen" or v.type== "gehege" then 
            if v.x ==  math.floor(x/30)*30 and v.y == math.floor(y/30)*30 then
                canPlace = false
            end
        end
    end 
    if canPlace == true then
        if spieler.inventar.gehege>=1 then
            spawnEntitaet("gehege", math.floor(x/30)*30, math.floor(y/30)*30)
            spieler.inventar.gehege = spieler.inventar.gehege -1
        end
    end
end

function findEntityByType(typ)
    for i, v in ipairs(Entitaeten) do
        if v.type == typ then
            return v
        end
    end
end

function love.mousepressed(x, y, button) 
    if button == 1 then
        local buttonClicked = false
        
        for i, btn in ipairs(kaufButtons) do
            if x >= btn.x and x <= btn.x + btn.width and y >= btn.y and y <= btn.y + btn.height then
                btn.action()
                buttonClicked = true
                break --beendet Schleife
            end
        end

        if not buttonClicked then
            for i, btn in ipairs(verkaufButtons) do
                if x >= btn.x and x <= btn.x + btn.width and y >= btn.y and y <= btn.y + btn.height then
                    btn.action()
                    buttonClicked = true
                    break
                end
            end
        end

        if not buttonClicked then
            if x >= screenWidth - 70 and x <= screenWidth - 70 + 25 and y >= 30 and y <= 55 then
                schreibeInfo = true
            else
                platziereGehege(camera.mouseX, camera.mouseY)
            end
        end
    end
    
    if button == 2 then
        platziereWeizen(camera.mouseX, camera.mouseY)   
    end
end

function platziereWeizen(x,y)
    local canPlace = true

    for i,v in ipairs(Entitaeten) do 
        if v.type== "weizen" or v.type== "gehege" then 
            if v.x ==  math.floor(x/30)*30 and v.y == math.floor(y/30)*30 then
                canPlace = false
            end
        end
    end 
    if canPlace == true then
        if spieler.inventar.weizen >= 1  then
            spieler.inventar.weizen = spieler.inventar.weizen -1
            spawnEntitaet("weizen", math.floor(x/30)*30, math.floor(y/30)*30)
        end
    end
    

end  

function removeDeadEntities(entities)
    for i = #entities, 1, -1 do
        local entity = entities[i]
        if entity.IsAlive == false then
            entity.fixture:destroy()        
            table.remove(entities, i)
        end
    end
end

function boden()
   local boden=love.graphics.newImage("Textures/boden.png")
   local bildschirmBreite=love.graphics.getWidth()
   local bildschirmHoehe= love.graphics.getHeight()
   local bodenBreite= boden:getWidth()*2
   local bodenHoehe = boden:getHeight()*2
    for x=0,bildschirmBreite,bodenBreite do
      for y=0, bildschirmHoehe,bodenHoehe do
        love.graphics.setColor(1,1,1)
        love.graphics.draw(boden,x,y,0,2)
      end
    end
end
     
function love.keypressed(key)
    if szene == 1 then 
        if key == "space" then
            szene = 2 
        end 
    end
    if szene == 2 then
    
        if key == "x" then
            mauspos = {x = camera.mouseX, y = camera.mouseY}
            for i, v in ipairs(Entitaeten) do
                if mauspos.x >= v.x and mauspos.x <= v.x+16 then
                    if mauspos.y >= v.y and mauspos.y <= v.y+16 then
                        if v.type == "gehege" then
                        spieler.inventar.gehege = spieler.inventar.gehege +1
                        v.IsAlive = false
                        end
                        if v.type == "weizen" then
                        spieler.inventar.weizen = spieler.inventar.weizen +1
                        v.IsAlive = false
                        end
                    end
                end
            end
        end
    end
end

function screenNichtVerlassen(entitaet)
    local x, y = entitaet.body:getPosition()
    if x < 0 then
        x = screenWidth
    elseif x > screenWidth then
        x = 0
    end
    if y < 0 then
        y = screenHeight
    elseif y > screenHeight then
        y = 0
    end
    entitaet.body:setPosition(x, y)
end

function zeichneInfo(x,y)
    love.graphics.rectangle("line",x,y,25,25)
    love.graphics.print("!",x+2,y-2,0,2)
    if schreibeInfo== true then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", x-400, y, 400, 150)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Info:", x-390, y+10)
        love.graphics.print("1.Melken = Taste f drücken", x-390, y+30)
        love.graphics.print("2.Schlachten = Taste q drücken", x-390, y+50)
        love.graphics.print("3.Züchten = Taste z drücken", x-390, y+70)
        love.graphics.print("4.Weizen Ernten = Taste e drücken", x-390, y+90)
        love.graphics.print("5.Löschen = Taste x drücken", x-390, y+110)
        love.graphics.print("6.Shop= Taste g drücken", x-390, y+130)
    end
end

function infoZeit(dt)
    if schreibeInfo==true then
    zeit = zeit + dt
        if zeit > 5 then
         schreibeInfo = false
         zeit=0
        end
    end
end

function audioAbspielen(dt)
    local tierLebt = false
    for _, v in ipairs(Entitaeten) do
            if (v.type == "kuh" or v.type == "schwein" or v.type == "schaf") and v.IsAlive then
                tierLebt = true
                break
            else
                tierLebt=false
            end
        end
     if tierLebt then
        for _,sounds in ipairs(soundTimer) do
                sounds.timer = sounds.timer + dt
            if sounds.timer >= sounds.interval then
                love.audio.play(sounds.sound)
                sounds.timer = sounds.timer - sounds.interval  
            end
        end
    end
end
function verkaufeWeizen()
    if spieler.inventar.weizen > 0 then
        spieler.inventar.weizen = spieler.inventar.weizen - 1
        spieler.inventar.geld = spieler.inventar.geld + 7
        love.audio.play(geldSound)
        verkaufe = false
    end
end

function verkaufeMilch()
    if spieler.inventar.milch > 0 then
        spieler.inventar.milch = spieler.inventar.milch - 1
        spieler.inventar.geld = spieler.inventar.geld + 10
        love.audio.play(geldSound)
    end
end

function verkaufeFleisch()
    if spieler.inventar.fleisch > 0 then
        spieler.inventar.fleisch = spieler.inventar.fleisch - 1
        spieler.inventar.geld = spieler.inventar.geld + 20
        love.audio.play(geldSound)
    end
end

function verkaufeWolle()
    if spieler.inventar.wolle > 0 then
        spieler.inventar.wolle = spieler.inventar.wolle - 1
        spieler.inventar.geld = spieler.inventar.geld + 15
        love.audio.play(geldSound)
    end
end

function verkaufeEi()
    if spieler.inventar.ei > 0 then
        spieler.inventar.ei = spieler.inventar.ei - 1
        spieler.inventar.geld = spieler.inventar.geld + 15
        love.audio.play(geldSound)
    end
end

function kaufeWeizen()
    if spieler.inventar.geld >= 5 then
        spieler.inventar.weizen = spieler.inventar.weizen + 1
        spieler.inventar.geld = spieler.inventar.geld - 5
        love.audio.play(geldSound)
    end
end

function kaufeGehege()
    if spieler.inventar.geld >= 5 then
        spieler.inventar.gehege = spieler.inventar.gehege + 1
        spieler.inventar.geld = spieler.inventar.geld -5
        love.audio.play(geldSound)
    end
end

function kaufeKuh()
    if spieler.inventar.geld >= 50 then
        spieler.inventar.geld = spieler.inventar.geld -50
        love.audio.play(geldSound)
        spawnEntitaet("kuh", spieler.x, spieler.y)
    end
end

function kaufeSchwein()
    if spieler.inventar.geld >= 30 then
        spieler.inventar.geld = spieler.inventar.geld -30
        love.audio.play(geldSound)
        spawnEntitaet("schwein", spieler.x, spieler.y)
    end
end

function kaufeSchaf()
    if spieler.inventar.geld >= 70 then
        spieler.inventar.geld = spieler.inventar.geld -70
        love.audio.play(geldSound)
        spawnEntitaet("schaf", spieler.x, spieler.y)
    end
end

function kaufeHuhn()
    if spieler.inventar.geld >= 80 then
        spieler.inventar.geld = spieler.inventar.geld -80
        love.audio.play(geldSound)
        spawnEntitaet("huhn", spieler.x, spieler.y)
    end
end