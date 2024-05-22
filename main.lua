function love.load()
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
end
function love.draw()
end
function love.update(dt)
    --test
end
function spawnEntitaet()
    local vorlageEntitaet=require("Entities/kuh")
    local entitaet={}
    for key,value in pairs(vorlageEntitaet) do
     entitaet[key]=value
    end
    table.insert(Entitaeten,entitaet)
end