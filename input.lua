local state = require 'state'

local input = {}

local keypressed = {
	escape = function() love.event.quit() end,
	r = function() state.data.altitude = 49900 end,
}

input.hold = function()
	if love.keyboard.isDown("up") then
		state.data.pitch = state.data.pitch + 1
	elseif love.keyboard.isDown("down") then
		state.data.pitch = state.data.pitch - 1
	end

	if love.keyboard.isDown("left") then
		state.data.roll = state.data.roll - math.pi / 180
	elseif love.keyboard.isDown("right") then
		state.data.roll = state.data.roll + math.pi / 180
	end

	if love.keyboard.isDown('z') then
		state.data.ias = state.data.ias + 1
	elseif love.keyboard.isDown('x') then
		state.data.ias = state.data.ias - 1
	end

	if love.keyboard.isDown('a') then
		state.data.altitude = state.data.altitude + 1
	elseif love.keyboard.isDown('s') then
		state.data.altitude = state.data.altitude - 1
	end

	if love.keyboard.isDown('q') then
		state.data.heading = state.data.heading - 1
	elseif love.keyboard.isDown('w') then
		state.data.heading = state.data.heading + 1
	end

	if love.keyboard.isDown('1') then
		state.data.vspeed = state.data.vspeed - 1
	elseif love.keyboard.isDown('2') then
		state.data.vspeed = state.data.vspeed + 1
	end
end

input.press = function(key)
	if keypressed[key] then
		keypressed[key]()
	end
end

input.release = function(key)
	if keyreleased[key] then
		keyreleased[key]()
	end
end

return input
