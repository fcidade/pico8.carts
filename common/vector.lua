-- Vec2

Vec2 = {}

function Vec2:new(x, y)
	local obj = {
        x = x
        ,y = y
    }
	setmetatable(obj, self)
    self.__index = self
	return obj
end

function Vec2:normalized()
    local length = sqrt(self.x * self.x + self.y * self.y)
    if length == 0 then
        return Vec2:new(0, 0)
    end
    return Vec2:new(self.x / length, self.y / length)
end

-- Rect

Rect = {}

function Rect:update(parent_x, parent_y)
    self.x = parent_x
    self.y = parent_y
end

function Rect:draw()
    color(rnd())
    rect(self.x, self.y, self.x + self.w, self.y + self.h)
end

function Rect:new(x, y, w, h)
	local obj = {
        x = x
        ,y = y
        ,w = w
        ,h = h
    }

	setmetatable(obj, self)
    self.__index = self
	return obj
end

function Rect:is_colliding_with(target)
    return not (
        self.x + self.w < target.x or
        self.x > target.x + target.w or
        self.y + self.h < target.y or
        self.y > target.y + target.h
    )
end