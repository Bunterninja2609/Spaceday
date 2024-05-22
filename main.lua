function love.load()
    World=love.physics.newWorld(0,0,true)
    love.physics.setMeter(32)
    Entitaeten={}
end
function love.draw()
end
function love.update(dt)
    --damit die physik-welt auf rechnet, muss eine funktion dafür hier hin... 
    --wenn es doch nur einfach wäre...
end
function spawnEntitaet()--ein Parameter für verschidene entitäten wäre schön... wie ginge das?
    local vorlageEntitaet=require("Entities/kuh")-- TIP: konkatiniert wird mit '..'
    local entitaet={}
    for key,value in pairs(vorlageEntitaet) do
     entitaet[key]=value
    end
    table.insert(Entitaeten,entitaet)
end