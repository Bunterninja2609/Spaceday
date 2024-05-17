local kuh={
    x=0,
    y=0,
    body=love.physics.newBody(World,kuh.x,kuh.y,"dynamic"),
    shape=love.physics.newCircleShape(16),
    fixture=love.physics.newFixture(kuh.body,kuh.shape)
}
function kuh.load()

end

function kuh.update(dt)

end

function kuh.draw()

end

return kuh

