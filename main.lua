local data = {
	altitude = 0,
	ias = 0,
	vspeed = 0,
	pitch = 0,
	roll = 0,
	heading = 0,
}

local keymap = {
	escape = function() love.event.quit() end,
}

function love.keypressed(key)
	if keymap[key] then
		keymap[key]()
	end
end

-- Main LOVE functions
function love.load()
end

function love.update(dt)
end

function love.draw()
	love.graphics.print("A " .. data.altitude, 20, 20)
	love.graphics.print("S " .. data.ias, 20, 40)
	love.graphics.print("V " .. data.vspeed, 20, 60)
	love.graphics.print("P " .. data.pitch, 200, 20)
	love.graphics.print("R " .. data.roll, 200, 40)
	love.graphics.print("H " .. data.heading, 200, 60)
end

