-- ⬅️➡️⬆️⬇️

Bullet = {}

function Bullet:update()
    -- local left_key, right_ley = 0, 1
    -- if btn(left_key) then
    --     self.pos.x -= 1
    -- end
    -- if btn(right_ley) then
    --     self.pos.x += 1
    -- end
    -- if self.pos.x <= 0 then
    --     self.pos.x = 0
    -- end
    
    -- if self.pos.x >= screen.w - self.w then
    --     self.pos.x = screen.w - self.w
    -- end
    self.pos.y -= 1
end


function Bullet:draw()
    color(colors.yellow)
    pset(self.pos.x, self.pos.y)
    color(colors.orange)
    pset(self.pos.x, self.pos.y + 1 )
end

function Bullet:new(init_x, init_y)
    local w = 16
	local obj = {
        spr = spr
        ,init_pos = Vec2:new(init_x, init_y)
        ,pos = Vec2:new(init_x, init_y)
        ,dir = Vec2:new(0, 0)
        ,spd = 2
        ,w = w
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end