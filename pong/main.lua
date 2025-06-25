-- main
-- ⬅️➡️⬆️⬇️

-- constants
tile_width = 8
tile_height = 8

screen_width = 128
screen_height = 128

field_top = tile_height * 2
goal_top = field_top + (tile_height * 4)
goal_bottom = screen_height - (tile_height * 5)
font_char_size = 4

p_init_y = flr((screen_height / 2) + (tile_height / 2))
p1_init_x = tile_width * 3
p2_init_x = screen_width - tile_width * 4

ball_init_x = flr((screen_width / 2) - (tile_width / 2))
ball_init_y = flr((screen_height / 2) + (tile_height / 2))

function _init()
	rawkeys_init()

	music(0)

	p1 = Player:new(0, 1, p1_init_x, p_init_y)
	p2 = Player:new(1, 2, p2_init_x, p_init_y)

	ball = Ball:new(ball_init_x, ball_init_y)
end

function player_score(player)
	player.score += 1
	p1:reset_position()
	p2:reset_position()
	ball:reset()
end

function _update()
	p1:update()
	p2:update()
	ball:update(p1, p2)

	if ball.pos.y > goal_top and ball.pos.y < goal_bottom then
		-- color(2)
		-- print('goal y', 0, 0)
		if ball.pos.x < (tile_width / 2) then
			-- print('goal 1', 0, tile_height)
			player_score(p1)
		end
		if ball.pos.x > screen_width - tile_width - (tile_width / 2) then
			-- print('goal 2', 0, tile_height)
			player_score(p2)
		end
	end
end

function _draw()
	cls()
	color(3)

	map(0, 0, 0, 0, 16, 16)
	map(16, 0, 0, 0, 16, 16)

	p1:draw()
	p2:draw()
	ball:draw()

	-- score
	color(2)
	print(p1.score, 0, 0)
	print(p2.score, screen_width - (font_char_size * #tostr(p2.score)), 0)
end
