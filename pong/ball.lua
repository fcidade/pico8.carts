-- ⬅️➡️⬆️⬇️

ball_spr = 3
ball_spr_coll = 4
ball_init_spd = 1

Ball = {
     x = 0
    ,y = 0
    ,dirx = ball_init_spd
    ,diry = ball_init_spd
    ,spd = ball_init_spd
}

function Ball:update()
    self.left = self.x
    self.right = self.x + tile_width
    self.top = self.y
    self.bottom = self.y + tile_height

    if self.left <= 0 then
        self.dirx = self.spd
    end
    if self.right >= screen_width then
        self.dirx = -self.spd
    end
    if self.top <= field_top then
        self.diry = self.spd
    end
    if self.bottom >= screen_height then
        self.diry = -self.spd
    end

    self.x += self.dirx
    self.y += self.diry
end

function Ball:check_player_coll(player)
    -- if self.coll_timer == nil then
    --     self.coll_timer = 0
    -- end
    -- self.coll_timer += 1
    -- if self.coll_timer < 500 then
    --     return
    -- end
    -- angle_player_and_ball = atan2(
    --     player.y - self.y,
    --     player.x - self.x
    -- )

    -- player_dir_angle = atan2(
    --     player.diry,
    --     player.dirx
    -- )

    -- n funciona pq ele ta sendo sobrescrito
    self.is_colliding = (
        self.left < player.right and
        self.right > player.left and
        self.top < player.bottom and
        self.bottom > player.top
    )
    -- if self.is_colliding then

    --     if player.dirx + player.diry != 0 then
    --         -- self.dirx = cos(player_dir_angle)
    --         -- self.diry = -sin(player_dir_angle)
    --     else
    --         self.dirx = cos(angle_player_and_ball)
    --         -- self.dirx = -cos(angle_player_and_ball) + cos(player_dir_angle)
    --                 -- self.dirx = cos(player_dir_angle)
    --         self.diry = -sin(angle_player_and_ball)
    --         -- self.diry = -sin(angle_player_and_ball) + sin(player_dir_angle)
    --                 -- self.diry = -sin(player_dir_angle)
    --     end
    -- end
end

function Ball:draw()
    if self.is_colliding then
        s = ball_spr
    else
        s = ball_spr_coll
    end

    spr(s, self.x, self.y)
end

function Ball:new(init_x, init_y)
	o = {}
	setmetatable(o, Ball)
    o.x = init_x
    o.y = init_y
    self.__index = self
	return o
end