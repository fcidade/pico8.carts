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
    local diry = 1
    if self.is_enemy then
        diry = -1
    end
    self.pos.y -= diry

    if self.pos.y > screen.h then
        self.deleted = true
    end
end

function Bullet:hit(hitby)
    if self.is_enemy then 
        return
    end
    self.deleted = true
end


function Bullet:draw()
    if self.is_enemy then 
        color(colors.red)
        circfill(self.pos.x, self.pos.y, 1)
        color(colors.orange)
        circfill(self.pos.x, self.pos.y + 1 , 1)
    else
        color(colors.yellow)
        pset(self.pos.x, self.pos.y)
        color(colors.orange)
        pset(self.pos.x, self.pos.y + 1 )
    end
end

function Bullet:new(init_x, init_y, is_enemy)
    local w = 16
	local obj = {
        spr = spr
        ,init_pos = Vec2:new(init_x, init_y)
        ,pos = Vec2:new(init_x, init_y)
        ,dir = Vec2:new(0, 0)
        ,spd = 2
        ,w = w
        , is_enemy = is_enemy
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end