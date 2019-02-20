require 'draw'
require 'overshoot'

data = {
	altitude = 0,
	ias = 0,
	vspeed = 0,
	pitch = 0,
	roll = 0,
	heading = 0,
}

local keymap = {
	escape = function() love.event.quit() end,
	r = function() data.pitch = 2000 end,
}

function love.keypressed(key)
	if keymap[key] then
		keymap[key]()
	end
end

function love.load()
	sans_file = "fonts/B612-Regular.ttf"
	sansbold_file = "fonts/B612-Bold.ttf"
	mono_file = "fonts/B612Mono-Regular.ttf"
	monobold_file = "fonts/B612Mono-Bold.ttf"

	sans = {
		normal = love.graphics.newFont(sans_file, 15),
		bold = love.graphics.newFont(sansbold_file, 15),
		label = love.graphics.newFont(sans_file, 15), 
	}

	mono = {
		normal = love.graphics.newFont(mono_file, 15),
		pitch = love.graphics.newFont(mono_file, 15),
		airspeed = love.graphics.newFont(mono_file, 25),
		airspeedbig = love.graphics.newFont(mono_file, 40),
	}
end

function love.update(dt)
	if love.keyboard.isDown("up") then
		data.pitch = data.pitch + 1
	elseif love.keyboard.isDown("down") then
		data.pitch = data.pitch - 1
	end

	if love.keyboard.isDown("left") then
		data.roll = data.roll - math.pi / 180
	elseif love.keyboard.isDown("right") then
		data.roll = data.roll + math.pi / 180
	end

	if love.keyboard.isDown('z') then
		data.ias = data.ias + 1
	elseif love.keyboard.isDown('x') then
		data.ias = data.ias - 1
	end

	if love.keyboard.isDown('a') then
		data.altitude = data.altitude + 10
	elseif love.keyboard.isDown('s') then
		data.altitude = data.altitude - 10
	end
end

function love.draw()
	debug_variables()
	artificial_horizon()
	airspeed_meter()
	altitude_indicator()

	if strings.toprint and strings[strings.numtoprint] then
		love.graphics.origin()
		love.graphics.setColor(1,1,1)
		love.graphics.setFont(sans.normal)
		love.graphics.printf(strings[strings.numtoprint], 400, 20, love.graphics.getWidth() - 420, 'left')
	end
end

