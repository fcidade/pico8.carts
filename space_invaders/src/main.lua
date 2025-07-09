-- Debug
dbg_messages = {}

function dprint(msg)
    if #dbg_messages > 3 then
        deli(dbg_messages, #dbg_messages)
    end
    add(dbg_messages, msg)
end

-- Constants
sprites = {
    player = {
        left = 64,
        middle = 66,
        right = 68,
    },
    enemy1 = { 16, 18 },
    enemy2 = { 20, 22 },
    enemy3 = { 24, 27 },
    barrier = {
        healthy = { 13, 14, 15, 29, 30, 31 },
        damaged = { 45, 46, 47, 61, 62, 63 },
    },
    heart = 1,
}

-- Main

local entities = {}
local enemies = {}
local grid_w = 6

local stars = {}

local score = 0

local StatePlaying = 0
local StateWon = 1
local StateLost = 2

-- local state = StateWon
local state = StatePlaying

function reset()
    state = StatePlaying
    score = 0
    player = Player:new()
    enemies = {}
    entities = {}

    for i = 0, (grid_w * 5) - 1 do
    -- for i = 0, (grid_w * 1) - 1 do
    -- for i = 0, (grid_w * 6) - 1 do
        local sprs = sprites.enemy1
        if i >= grid_w * 4 then
            sprs = sprites.enemy2
        elseif i >= grid_w * 2 then
            sprs = sprites.enemy3
        end
        add(enemies, Enemy:new(i % grid_w, flr(i / grid_w), sprs))
    end
end

function _init()
    player = Player:new()

    reset()

    for i = 0, 100 do
        stars[i] = { x = rnd(screen.w), y = rnd(screen.h), spd = rnd(3) + 1 }
    end
end

function instantiate(entity)
    add(entities, entity)
end

function _update()
    if state ~= StatePlaying then
        if btnp(4) or btnp(5) then
            reset()
        end
        return
    end

    -- Remove deleted entities from the entities table
    for i = #entities, 1, -1 do
        if entities[i].deleted then
            deli(entities, i)
        end
    end

    foreach(entities, function(entity)
        if entity.deleted then
            return
        end
        if entity.is_enemy then
            if entity.pos.x >= player.pos.x
                and entity.pos.x <= player.pos.x + 16
                and entity.pos.y >= player.pos.y
                and entity.pos.y <= player.pos.y + 16
            then
                entity:hit(player)
                player:hit(entity)
            end
            return
        end
        foreach(enemies, function(enemy)
            if enemy.deleted then
                return
            end
            if entity.pos.x >= enemy.pos.x
                and entity.pos.x <= enemy.pos.x + 16
                and entity.pos.y >= enemy.pos.y
                and entity.pos.y <= enemy.pos.y + 16
            then
                enemy:hit(entity)
                entity:hit(enemy)
                if enemy.life <= 0 then
                    score += 100
                end
            end
        end)
    end)

    local all_enemies_dead = true
    local enemies_invaded = false
    foreach(enemies, function(e)
        if e.deleted then
            return
        end
        all_enemies_dead = false
        if e.pos.y >= screen.h then
            enemies_invaded = true
        end
        e:update()
    end)
    if all_enemies_dead then
        state = StateWon
    end
    if enemies_invaded then
        state = StateLost
    end
    if player.deleted or player.life <= 0 then
        state = StateLost
    end
    foreach(entities, function(e)
        if e.deleted then
            return
        end
        e:update()
    end)


    player:update()

    foreach(stars, function(e)
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

    if state == StateWon then
        print("you won!")
        print("press any key to continue!", 0, 16)
        return
    end
    if state == StateLost then
        print("you lost!")
        print("press any key to continue!", 0, 16)
        return
    end
    

    if state ~= StatePlaying then
        return
    end

    --
    foreach(stars, function(e)
        -- pset(e.x, e.y, colors.dark_blue)
        local trailsize = e.spd
        line(e.x, e.y, e.x, e.y - trailsize, colors.dark_blue)
    end)

    foreach(enemies, function(e)
        if e.deleted then
            return
        end
        e:draw()
    end)
    foreach(entities, function(e)
        if e.deleted then
            return
        end
        e:draw()
    end)
    player:draw()

    -- Score
    color(colors.white)
    print("score: " .. tostr(score), 0, 0)

    -- Lifes
    for life = 1,player.life do
        spr(sprites.heart, 128-life*10, 0)
    end

    -- Debug
    local y = 0
    foreach(dbg_messages, function(m)
        print(m, 20, 20 + y)
        y += 6
    end)

    -- mais debug
    -- print("# entities = " .. tostr(#entities), 0, 128-8)
end