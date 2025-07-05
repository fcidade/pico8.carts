-- Constants
sprites = {
    player = {
        left = 64, 
        middle = 66, 
        right = 68,
    },
    enemy1 = {16, 18},
    enemy2 = {20, 22},
    enemy3 = {24, 27},
    barrier = {
        healthy = {13, 14, 15, 29, 30, 31},
        damaged = {45, 46, 47, 61, 62, 63},
    }
}

-- Main

entities = {}
enemies = {}
grid_w = 6

stars = {}

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

    for i=0, 100 do
        stars[i] = {x = rnd(screen.w), y = rnd(screen.h), spd = rnd(3) + 1}
    end
end

function instantiate(entity) 
    add(entities, entity)
end

function _update() 
    cls()
    foreach(enemies, function (e)
        e:update()
    end)
    foreach(entities, function (e)
        e:update()
    end)
    player:update()

    foreach(stars, function (e)
        e.y += e.spd
        if e.y > screen.h then
            e.y = 0
            e.x = rnd(screen.w)
            e.spd = rnd(3) + 1
        end
    end)

end


function _draw() 
    cls(colors.black)
    -- line(0, 0, 0, screen.h, colors.dark_blue)
    -- line(screen.w - 1, 0, screen.w - 1, screen.h, colors.dark_blue)

    foreach(stars, function (e)
        -- pset(e.x, e.y, colors.dark_blue)
        local trailsize = e.spd
        line(e.x, e.y,e.x, e.y-trailsize, colors.dark_blue)
    end)

    -- for i = 0, screen.w/16+1 do
    --     for j = 0, screen.h/16+1 do
    --         if (i + j) % 2 == 0 then
    --             color(colors.indigo)
    --         else
    --             color(colors.peach)
    --         end
    --         local x, y = i*16, j*16
    --         rectfill(x, y, x+ 16, y+16)
    --     end 
    -- end 

    foreach(enemies, function (e)
        e:draw()
    end)
    foreach(entities, function (e)
        e:draw()
    end)
    player:draw()

end