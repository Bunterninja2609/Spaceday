function love.load()
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
    spawnEntitaet("kuh")
    spawnEntitaet("gehege")
    spawnEntitaet("spieler")
    spawnEntitaet("weizen")
end

function love.draw()
    love.graphics.setBackgroundColor(58/256, 68/256, 102/256)
   for i,v in ipairs(Entitaeten) do 
    v:draw()
   end
end

function love.update(dt)
    for i,v in ipairs(Entitaeten) do 
        v:update(dt)
    end
    World:update(dt)
end

function spawnEntitaet(typ, x, y) --für position
    local vorlageEntitaet=require("Entities/"..typ)
    local entitaet={}
    for key,value in pairs(vorlageEntitaet) do
     entitaet[key]=value
    end
    entitaet.x, entitaet.y = x, y --wäre eine möglichkeit
    table.insert(Entitaeten,entitaet)
end

function platziereGehege(x,y)
    if true then
        spawnEntitaet("gehege")     
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
        local kuh = findEntityByType("kuh")
        if kuh then
            kuh:IsClicked(x, y)
        end
        platziereGehege(x,y) 
    end
    if button == 2 then
        platziereWeizen(x,y)
    end 
end

function platziereWeizen(x,y)
    if true then
        spawnEntitaet("weizen")     
    end
end  
     
function love.keypressed(key)
    if szene == 1 then 
        if key == "space" then
            szene = 2 
        end 
    end
end