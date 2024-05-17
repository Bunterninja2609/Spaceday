function love.load()
end
function love.draw()
end
function love.update(dt)
    --test
end
function draw( drawable, x, y, r, width, height, ox, oy, kx, ky )
    love.graphics.draw( drawable, x, y, r, width / drawable:getWidth() , height / drawable:getHeight() , ox, oy, kx, ky )
end