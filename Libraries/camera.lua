camera = {x = 0, y = 0, offsetX = 0, offsetY = 0,mouseX = 0, mouseY = 0, scale = 3}
function camera.init()
    love.graphics.push() -- startet den einfluss der Kamera
    love.graphics.translate(-camera.x*camera.scale + camera.offsetX, -camera.y*camera.scale + camera.offsetY) -- versetzt den Bildschirm
    love.graphics.scale(camera.scale) -- zoomt rein
    camera.mouseX = (camera.x + love.mouse:getX()/camera.scale) - camera.offsetX/ camera.scale-- neue x-koordinate der maus nach verschieben und zoomen
    camera.mouseY = (camera.y + love.mouse:getY()/camera.scale) - camera.offsetY/ camera.scale-- neue y-koordinate der maus nach verschieben und zoomen
end
function camera.exit()
    love.graphics.pop() -- beendet den einfluss der Kamera
end
function camera.follow(x, y, isCentered) -- sorgt dafür, dass die Kamera bestimmten Koordinaten folgt
    camera.x, camera.y = x, y
    if isCentered then
        camera.offsetX, camera.offsetY = love.graphics.getWidth()/2, love.graphics.getHeight()/2 -- zentriert die Kamera
    end
end