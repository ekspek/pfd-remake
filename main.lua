require 'load'
require 'update'
require 'draw'

data = {
	altitude = 0,
	ias = 0,
	vspeed = 0,
	pitch = 0,
	roll = 0,
	heading = 0,
}

pitchmax = 90
rollmax = 60 * math.pi / 180

local keymap = {
	escape = function() love.event.quit() end,
}

function love.keypressed(key)
	if keymap[key] then
		keymap[key]()
	end
end

function love.load()
	sans = love.graphics.newFont("fonts/B612-Regular.ttf", 15)
	mono = love.graphics.newFont("fonts/B612Mono-Regular.ttf", 15)
	sans_label = love.graphics.newFont("fonts/B612-Regular.ttf", 15)

	local pitch_up = true
	local roll_left = true
end

function love.update(dt)
	--[[
	data.altitude = data.altitude + (math.random() - 0.5) * 10
	data.ias = data.ias + (math.random() - 0.5) * 10
	data.vspeed = data.vspeed + (math.random() - 0.5) * 10
	data.pitch = data.pitch + (math.random() - 0.5) * 5
	data.roll = data.roll + (math.random() - 0.5) * 10
	data.heading = data.heading + (math.random() - 0.5) * 10
	--]]
	if data.pitch > pitchmax then
		data.pitch = pitchmax
		pitch_up = false
	end
	if data.pitch < -pitchmax then
		data.pitch = -pitchmax
		pitch_up = true
	end
	if pitch_up then data.pitch = data.pitch + 0.3 else data.pitch = data.pitch - 0.3 end
	if data.roll > rollmax then
		data.roll = rollmax
		roll_left = false
	end
	if data.roll < -rollmax then
		data.roll = -rollmax
		roll_left = true
	end
	if roll_left then data.roll = data.roll + math.pi / 180 else data.roll = data.roll - math.pi / 180 end
end

function love.draw()
	artificial_horizon()
end

