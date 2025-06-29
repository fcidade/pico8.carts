-- ⬅️➡️⬆️⬇️

Enemy = {}

local top_left = Vec2:new(16, 8)

function Enemy:update()
end

function Enemy:draw()
    local x, y = self.pos.x * self.w, self.pos.y * self.w
    local sprite = self.sprites[1]
    -- ideia: usar sin(time()) p/ fazer a animacao do inimigo voando, e faz um timer pra de quanto em quanto tempo ele desce

    x = x + (sin(t()/2) * 2)
    y = y + (cos(t()) * 1)

    x, y = x + top_left.x, y + top_left.y

    color(3)
    spr(sprite, x, y, 2, 2)
    -- rect(x, y, x + self.w, y + self.w)
    -- print(sprite, x, y + 60)
end

function Enemy:new(grid_x, grid_y, sprites)
    local obj = {
        pos = Vec2:new(grid_x, grid_y),
        w = 16,
        sprites = sprites,
        coll_rect = Rect:new(0, 0, 8, 8)
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end
