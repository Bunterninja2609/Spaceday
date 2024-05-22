function love.load()
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
end
function love.draw()
end
function love.update(dt)
    World:update(dt)
end
function spawnEntitaet(typ)--ein Parameter für verschidene entitäten wäre schön... wie ginge das?
    local vorlageEntitaet=require("Entities"..typ)-- TIP: konkatiniert wird mit '..'
    local entitaet={}
    for key,value in pairs(vorlageEntitaet) do
     entitaet[key]=value
    end
    table.insert(Entitaeten,entitaet)
end