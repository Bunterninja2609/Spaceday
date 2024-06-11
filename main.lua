require "startscreen"
function love.load()
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
    for i = 1, 3 do
        spawnEntitaet("kuh", love.math.random(100, 700), love.math.random(100, 500))
    end
    for i = 1, 3 do
        spawnEntitaet("schwein", love.math.random(100, 700), love.math.random(100, 500))
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
end