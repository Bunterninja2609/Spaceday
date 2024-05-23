function love.load()
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
end
function love.draw()
    -- jetzt brauchen wir noch einen ipairs loop um alle entitäten zu zeichnen
end
function love.update(dt)
    -- jetzt brauchen wir noch einen ipairs loop um alle entitäten zu updaten
    World:update(dt)
end
function spawnEntitaet(typ)
    local vorlageEntitaet=require("Entities"..typ)
    local entitaet={}
    for key,value in pairs(vorlageEntitaet) do
     entitaet[key]=value
    end
    table.insert(Entitaeten,entitaet)
end

function platziereGehege(x,y)
    if genugGeld == true then
        spawnEntitaet(gehege)
    end
end