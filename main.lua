function love.load()
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
    spawnEntitaet("kuh")
    spawnEntitaet("gehege")
    spawnEntitaet("spieler")
end

function love.draw()
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



function spawnEntitaet(typ)
    local vorlageEntitaet=require("Entities/"..typ)
    local entitaet={}
    for key,value in pairs(vorlageEntitaet) do
     entitaet[key]=value
    end
    table.insert(Entitaeten,entitaet)
end

function platziereGehege(x,y)
    if true then
        spawnEntitaet("gehege")     
    end
end

function love.mousepressed(x,y,button) 
    if button == 1 then
        platziereGehege(x,y)
    end
end