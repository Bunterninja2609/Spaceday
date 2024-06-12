require "startscreen"
function love.load()
    love.graphics.setDefaultFilter("nearest","nearest")
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
    for i = 0, 100 do
        spawnEntitaet("kuh")
    end
    spawnEntitaet("gehege")
    spawnEntitaet("spieler")
    spawnEntitaet("weizen")
    spawnEntitaet("schwein")
    --removeDeadEntities(kuehe)   
    --removeDeadEntities(schweine)
    startscreen.load()

end

function love.draw()
    boden()
   for i,v in ipairs(Entitaeten) do 
    v:draw()
   end
   startscreen.draw()
end

function love.update(dt)
   
    for i,v in ipairs(Entitaeten) do 
        v:update(dt) 
        screenNichtVerlassen(v)
    end
    World:update(dt)
end

function spawnEntitaet(typ, x, y) 
    local vorlageEntitaet=require("Entities/"..typ)
    local entitaet={}
    for key,value in pairs(vorlageEntitaet) do
     entitaet[key]=value
    end
    entitaet.x, entitaet.y = x, y 
    entitaet: load()
    table.insert(Entitaeten,entitaet)
end

function platziereGehege(x,y)
    if true then
        spawnEntitaet("gehege", math.floor(x/16)*16, math.floor(y/16)*16)     
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
      --  local kuh = findEntityByType("kuh")
       -- if kuh then
       --     kuh:IsClickedMilch(x, y)
       -- end
        platziereGehege(x,y) 
    end
    if button == 2 then
        platziereWeizen(x,y)   
    end

end

function platziereWeizen(x,y)
    if true then
        spawnEntitaet("weizen",math.floor(x/16)*16,math.floor(y/16)*16)    
    end

end  

function removeDeadEntities(entities)
    for i = #entities, 1, -1 do
        local entity = entities[i]
        if entity.IsAlive == false then
            
            table.remove(entities, i)
        end
    end
end

function boden()
   local boden=love.graphics.newImage("Textures/boden.png")
   local bildschirmBreite=love.graphics.getWidth()
   local bildschirmHoehe= love.graphics.getHeight()
   local bodenBreite= boden:getWidth()
   local bodenHoehe = boden:getHeight()
    for x=0,bildschirmBreite,bodenBreite do
      for y=0, bildschirmHoehe,bodenHoehe do
        love.graphics.draw(boden,x,y)
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
        if key == "1" then
            if spieler.inventar.milch > 0 then
                spieler.inventar.milch = spieler.inventar.milch - 1
                spieler.inventar.geld = spieler.inventar.geld + 10
            end
        end
        if key == "2" then
            if spieler.inventar.fleisch > 0 then
                spieler.inventar.fleisch = spieler.inventar.fleisch - 1
                spieler.inventar.geld = spieler.inventar.geld + 20
            end
        end
        if key == "3" then
            if spieler.inventar.weizen > 0 then
                spieler.inventar.weizen = spieler.inventar.weizen - 1
                spieler.inventar.geld = spieler.inventar.geld + 5
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
