require 'indicators.airspeed'
require 'indicators.altitude'
require 'indicators.heading'
require 'indicators.horizon'
require 'indicators.vspeed'
require 'other'

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
	r = function() data.altitude = 49900 end,
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
		text = love.graphics.newFont(sans_file, 25), 
		textsmall = love.graphics.newFont(sans_file, 15), 
	}

	mono = {
		normal = love.graphics.newFont(mono_file, 15),
		pitch = love.graphics.newFont(mono_file, 15),
		airspeed = love.graphics.newFont(mono_file, 25),
		airspeedbig = love.graphics.newFont(mono_file, 40),
		altitude = love.graphics.newFont(mono_file, 18),
		altitudebig = love.graphics.newFont(mono_file, 35),
		compass = love.graphics.newFont(mono_file, 15),
		compassbig = love.graphics.newFont(monobold_file, 35),
		compasshorizon = love.graphics.newFont(monobold_file, 18),
		vspeed = love.graphics.newFont(monobold_file, 18),
		text = love.graphics.newFont(mono_file, 25),
		textsmall = love.graphics.newFont(mono_file, 15),
	}

	colors = {
		white = {1, 1, 1, 1},
		black = {0, 0, 0, 1},
		gray = {0.47, 0.47, 0.47, 1},
		skyblue = {0.4, 0.4, 1, 1},
		groundbrown = {0.7, 0.5, 0, 1},
		lettergreen = {0.5, 1, 0.5, 1},
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
		data.altitude = data.altitude + 1
	elseif love.keyboard.isDown('s') then
		data.altitude = data.altitude - 1
	end

	if love.keyboard.isDown('q') then
		data.heading = data.heading - 1
	elseif love.keyboard.isDown('w') then
		data.heading = data.heading + 1
	end

	if love.keyboard.isDown('1') then
		data.vspeed = data.vspeed - 1
	elseif love.keyboard.isDown('2') then
		data.vspeed = data.vspeed + 1
	end
end

function love.draw()
	debug_variables()
	artificial_horizon()
	airspeed_meter()
	vspeed_indicator()
	altitude_indicator()
	heading_indicator()

	if strings.toprint and strings[strings.numtoprint] then
		love.graphics.origin()
		love.graphics.setColor(colors.white)
		love.graphics.setFont(sans.normal)
		love.graphics.printf(strings[strings.numtoprint], 400, 20, love.graphics.getWidth() - 420, 'left')
	end
end

