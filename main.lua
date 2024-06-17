require "startscreen"
function love.load()
    love.graphics.setDefaultFilter("nearest","nearest")
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
    for i = 0, 3 do
       spawnEntitaet("kuh", 500, 300)
    end
    spawnEntitaet("gehege")
    spawnEntitaet("spieler", 500, 50)
    --spawnEntitaet("weizen")
    for i =0,3 do
        spawnEntitaet("schwein")
    end
    for i =0,3 do
        spawnEntitaet("schaf")
    end
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
end

function love.draw()
    boden()
    table.sort(Entitaeten, function(a, b) return a.body:getY() < b.body:getY() end) --!!diese Funktion sorgt dafür, dass die Entitaeten weiter hinten zuerst gezeichnet werden!!--
   for i,v in ipairs(Entitaeten) do
    v:draw()
   end
   zeichneInfo(1100,30)
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
        if v.type== "weizen" then 
            if v.x ==  math.floor(x/30)*30 and v.y == math.floor(y/30)*30 then
                canPlace = false
            end
        end
    end 
    if canPlace == true then
        spawnEntitaet("gehege", math.floor(x/30)*30, math.floor(y/30)*30)
        if spieler.inventar.geld < 5 then
            spieler.inventar.weizen = spieler.inventar.weizen -2
        elseif spieler.inventar.geld >= 5 then
            spieler.inventar.geld = spieler.inventar.geld-5
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

function love.mousepressed(x,y,button) 
    if button == 1 then
        if x >= 1100 and x <= 1125 and y >= 30 and y <= 55 then
            schreibeInfo=true
            return true
        else 
            platziereGehege(x,y)
        end
    end
    if button == 2 then
        platziereWeizen(x,y)   
       -- for i, v in ipairs(Entitaeten) do
         --   if v.type == "gehege" then
         --      v.IsAlive = false
        --    end
       -- end
    end
end

function platziereWeizen(x,y)
    if true then
        spawnEntitaet("weizen",math.floor(x/30)*30,math.floor(y/30)*30)    
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
        if spieler.nutzeShop == true then 
            if key == "1" then
                if spieler.inventar.milch > 0 then
                    spieler.inventar.milch = spieler.inventar.milch - 1
                    spieler.inventar.geld = spieler.inventar.geld + 10
                    love.audio.play(geldSound)
                end
            end
            if key == "2" then
                if spieler.inventar.fleisch > 0 then
                    spieler.inventar.fleisch = spieler.inventar.fleisch - 1
                    spieler.inventar.geld = spieler.inventar.geld + 20
                    love.audio.play(geldSound)
                end
            end
            if key == "3" then
                if spieler.inventar.wolle > 0 then
                    spieler.inventar.wolle = spieler.inventar.wolle - 1
                    spieler.inventar.geld = spieler.inventar.geld + 15
                    love.audio.play(geldSound)
                end
            end
            if key == "4" then
                if spieler.inventar.weizen > 0 then
                    spieler.inventar.weizen = spieler.inventar.weizen - 1
                    spieler.inventar.geld = spieler.inventar.geld + 5
                    love.audio.play(geldSound)
                end
            end
        end
    end
end

function screenNichtVerlassen(entitaet)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
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
        love.graphics.rectangle("fill", x, y, 400, 150)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Info:", x+10, y+10)
        love.graphics.print("1.Melken = Taste f drücken", x+10, y+30)
        love.graphics.print("2.Schlachten = Taste q drücken", x+10, y+50)
        love.graphics.print("3.Züchten = Taste e drücken", x+10, y+70)
        love.graphics.print("4.Weizen Ernten = Taste e drücken", x+10, y+90)
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