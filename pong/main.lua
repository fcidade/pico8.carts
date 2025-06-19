-- main
-- ⬅️➡️⬆️⬇️

-- constants
tile_width = 8
tile_height = 8

screen_width = 128
screen_height = 128

field_top = tile_height * 2

p_init_y = flr((screen_height / 2) + (tile_height / 2))
p1_init_x = tile_width * 3
p2_init_x = screen_width - tile_width * 4

ball_init_x = flr((screen_width / 2) - (tile_width/2))
ball_init_y = flr((screen_height / 2) + (tile_height/2))

function _init()
	-- music(0)

	p1 = Player:new(0, 1, p1_init_x, p_init_y)
	p2 = Player:new(1, 2, p2_init_x, p_init_y)

	ball = Ball:new(ball_init_x, ball_init_y)
end

function _update()
	p1:update()
	p2:update()
	ball:update(p1, p2)

	-- ball:check_player_coll(p1)
	-- ball:check_player_coll(p2)
	
end

function _draw()
	cls() 
	map(0 ,	0,	0,	0, 16, 16)
	map(16, 0,	0,	0,	16,	16)

	p1:draw()
	p2:draw()
	ball:draw()
end