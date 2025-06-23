-- ⬅️➡️⬆️⬇️

Player = {}

function Player:update()
    self.left = self.pos.x
    self.right = self.pos.x + tile_width
    self.top = self.pos.y
    self.bottom = self.pos.y + tile_height
    
    self.dir.x = 0
    self.dir.y = 0

    if btn(⬅️, self.id) and self.left > 0 then
        self.dir.x -= self.spd
    end
    if btn(➡️, self.id) and self.right < screen_width then
        self.dir.x += self.spd
    end
    if btn(⬆️, self.id) and self.top > field_top then
        self.dir.y -= self.spd
    end
    if btn(⬇️, self.id) and self.bottom < screen_height then
        self.dir.y += self.spd
    end

    self.pos.x += self.dir.x
    self.pos.y += self.dir.y

    self.coll_rect:update(self.pos.x, self.pos.y)
end

function Player:draw()
    spr(self.spr, self.pos.x, self.pos.y)

    self.coll_rect:draw()
end

function Player:reset_position()
    self.pos.x = self.init_pos.x
    self.pos.y = self.init_pos.y
end

function Player:new(id, spr, init_x, init_y)
	local obj = {
        id = id
        ,spr = spr
        ,init_pos = Vec2:new(init_x, init_y)
        ,pos = Vec2:new(init_x, init_y)
        ,dir = Vec2:new(0, 0)
        ,spd = 2
        ,coll_rect = Rect:new(0,0,8,8)
        ,score = 0
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end