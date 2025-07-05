-- ⬅️➡️⬆️⬇️

Player = {}

function Player:update()
    self.spr = sprites.player.middle
    if btn(keys.left) then
        self.spr = sprites.player.left
        self.pos.x -= 1
    end
    if btn(keys.right) then
        self.spr = sprites.player.right
        self.pos.x += 1
    end
    if self.pos.x <= 0 then
        self.pos.x = 0
    end

    if btn(keys.a) then
        sfx(0)
        instantiate(Bullet:new(self.pos.x, self.pos.y))
    end

    if self.pos.x >= screen.w - self.w then
        self.pos.x = screen.w - self.w
    end
end

function Player:draw()
    spr(self.spr, self.pos.x, self.pos.y, 2, 2)
end

function Player:new()
    local w = 16
    local init_x, init_y = flr(screen.w / 2) - flr(w / 2), screen.h - w
    local obj = {
        spr = sprites.player.middle,
        init_pos = Vec2:new(init_x, init_y),
        pos = Vec2:new(init_x, init_y),
        dir = Vec2:new(0, 0),
        spd = 2,
        w = w,
        coll_rect = Rect:new(0, 0, w, w)
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end
