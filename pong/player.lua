-- ⬅️➡️⬆️⬇️

Player = {
     id = 0
    ,spr = 0
    ,x = 0
    ,y = 0
    ,spd = 2
}

function Player:update()
    self.left = self.x
    self.right = self.x + tile_width
    self.top = self.y
    self.bottom = self.y + tile_height
    
    self.dirx = 0
    self.diry = 0

    if btn(⬅️, self.id) and self.left > 0 then
        self.dirx -= self.spd
    end
    if btn(➡️, self.id) and self.right < screen_width then
        self.dirx += self.spd
    end
    if btn(⬆️, self.id) and self.top > field_top then
        self.diry -= self.spd
    end
    if btn(⬇️, self.id) and self.bottom < screen_height then
        self.diry += self.spd
    end

    self.x += self.dirx
    self.y += self.diry
end

function Player:draw()
    spr(self.spr, self.x, self.y)
end

function Player:new(id, spr, init_x, init_y)
	o = {}
	setmetatable(o, Player)
	o.id = id
	o.spr = spr
    o.x = init_x
    o.y = init_y
    self.__index = self
	return o
end