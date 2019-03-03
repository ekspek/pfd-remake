local state = require 'state'

local input = {}

local unitrate = 50

local keypressed = {
	escape = function() love.event.quit() end,
	r = function() state.data.pitch = 190 end,
}

input.hold = function(dt)
	if love.keyboard.isDown("up") then
		state.data.pitch = state.data.pitch + (unitrate * dt)
	elseif love.keyboard.isDown("down") then
		state.data.pitch = state.data.pitch - (unitrate * dt)
	end

	if love.keyboard.isDown("left") then
		state.data.roll = state.data.roll - (math.pi * unitrate * dt / 180)
	elseif love.keyboard.isDown("right") then
		state.data.roll = state.data.roll + (math.pi * unitrate * dt / 180)
	end

	if love.keyboard.isDown('z') then
		state.data.ias = state.data.ias + (unitrate * dt)
	elseif love.keyboard.isDown('x') then
		state.data.ias = state.data.ias - (unitrate * dt)
	end

	if love.keyboard.isDown('a') then
		state.data.altitude = state.data.altitude + (unitrate * dt)
	elseif love.keyboard.isDown('s') then
		state.data.altitude = state.data.altitude - (unitrate * dt)
	end

	if love.keyboard.isDown('q') then
		state.data.heading = state.data.heading - (unitrate * dt)
	elseif love.keyboard.isDown('w') then
		state.data.heading = state.data.heading + (unitrate * dt)
	end

	if love.keyboard.isDown('1') then
		state.data.vspeed = state.data.vspeed - (unitrate * dt)
	elseif love.keyboard.isDown('2') then
		state.data.vspeed = state.data.vspeed + (unitrate * dt)
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
