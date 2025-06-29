-- Constants
sprites = {
    player = {64, 66},
    enemy1 = {16, 18},
    enemy2 = {20, 22},
    enemy3 = {24, 27},
    barrier = {
        healthy = {13, 14, 15, 29, 30, 31},
        damaged = {45, 46, 47, 61, 62, 63},
    }
}

-- Main

enemies = {}
grid_w = 6

function _init() 
    player = Player:new()

    for i=0,(grid_w * 5) - 1 do
        local sprs = sprites.enemy1
        if i >= grid_w * 4 then
            sprs = sprites.enemy2
        elseif i >= grid_w * 2 then
            sprs = sprites.enemy3
        end
        add(enemies, Enemy:new(i % grid_w, flr(i / grid_w), sprs))
    end
end


function _update() 
    cls()
    foreach(enemies, function (e)
        e:update()
    end)
    player:update()

end


function _draw() 
    cls()

    for i = 0, screen.w/16+1 do
        for j = 0, screen.h/16+1 do
            if (i + j) % 2 == 0 then
                color(colors.indigo)
            else
                color(colors.peach)
            end
            local x, y = i*16, j*16
            rectfill(x, y, x+ 16, y+16)
        end 
    end 

    foreach(enemies, function (e)
        e:draw()
    end)
    player:draw()

end