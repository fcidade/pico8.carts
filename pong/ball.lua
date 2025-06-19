-- ⬅️➡️⬆️⬇️

ball_spr = 3
ball_spr_coll = 4
ball_init_spd = 2

Ball = {}

function Ball:update(player1, player2)

    self.is_colliding_with_p1 = self:check_player_coll(player1) 
    self.is_colliding_with_p2 = self:check_player_coll(player2)
    self.is_colliding = (
        self.is_colliding_with_p1
        or self.is_colliding_with_p2
    )

    self.left = self.pos.x
    self.right = self.pos.x + tile_width
    self.top = self.pos.y
    self.bottom = self.pos.y + tile_height

    if self.left <= 0 then
        self.dir.x = self.spd
    end
    if self.right >= screen_width then
        self.dir.x = -self.spd
    end
    if self.top <= field_top then
        self.dir.y = self.spd
    end
    if self.bottom >= screen_height then
        self.dir.y = -self.spd
    end

    if self.is_colliding_with_p1 then
        self.dir.x += player1.dir.x
        self.dir.y += player1.dir.y
    end

    if self.is_colliding_with_p2 then
        self.dir.x += player2.dir.x
        self.dir.y += player2.dir.y
    end

    self.dir = self.dir:normalized()

    self.pos.x += self.dir.x * self.spd
    self.pos.y += self.dir.y * self.spd


    self.coll_rect:update(self.pos.x, self.pos.y)
end

function Ball:check_player_coll(player)
    return self.coll_rect:is_colliding_with(player.coll_rect)
end

function Ball:draw()
    if self.is_colliding then
        s = ball_spr
    else
        s = ball_spr_coll
    end

    spr(s, self.pos.x, self.pos.y)

    self.coll_rect:draw()
    print(self.is_colliding)
end

function Ball:new(init_x, init_y)
	local obj = {
        pos = Vec2:new(init_x, init_y)
        ,dir = Vec2:new(0, 0)
        ,spd = ball_init_spd
        ,coll_rect = Rect:new(0,0,8,8)
    }
	setmetatable(obj, self)
    self.__index = self
	return obj
end