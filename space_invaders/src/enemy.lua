-- ⬅️➡️⬆️⬇️

local top_left = Vec2:new(16, 8)

Enemy = {}
function Enemy:new(grid_x, grid_y, sprites)
    local w = 16
    local x, y = grid_x * w + top_left.x, grid_y * w + top_left.y
    local obj = {
        life = 3,
        pos = Vec2:new(x, y),
        w = 16,
        sprites = sprites,
        coll_rect = Rect:new(0, 0, 8, 8),
        walk_down_timer = 0,
        shoot_timer = 0,
        shoot_delay = rnd(1000) + 100,
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Enemy:update()
    if self.life <= 0 then
        self.deleted = true
        return
    end

    self.shoot_timer += 1
    if self.shoot_timer >= self.shoot_delay then
        self.shoot_timer = 0
        instantiate(Bullet:new(self.pos.x + 7, self.pos.y, true))
    end
end

function Enemy:hit(hitby)
    if not hitby.is_enemy then
        self.life -= 1
    end
end

function Enemy:draw()
    local sprite = self.sprites[1]
    -- ideia: usar sin(time()) p/ fazer a animacao do inimigo voando, e faz um timer pra de quanto em quanto tempo ele desce

    local x = self.pos.x + (sin(t()) * 1)
    local y = self.pos.y + (cos(t()) * 1)

    self.walk_down_timer += 1
    if self.walk_down_timer > 100 then
        self.pos.y += 4
        self.walk_down_timer = 0
    end

    -- x, y = x + top_left.x, y + top_left.y

    color(3)
    spr(sprite, x, y, 2, 2)
    -- rect(x, y, x + self.w, y + self.w)
    -- print(sprite, x, y + 60)
end
