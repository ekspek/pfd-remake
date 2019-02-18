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
	data.altitude = data.altitude + (math.random() - 0.5) * 10
	data.ias = data.ias + (math.random() - 0.5) * 10
	data.vspeed = data.vspeed + (math.random() - 0.5) * 10
	data.pitch = data.pitch + (math.random() - 0.5) * 5
	data.roll = data.roll + (math.random() - 0.5) * 10
	data.heading = data.heading + (math.random() - 0.5) * 10
end

function love.draw()
	local pitch_scale_factor = 6
	local pitch_pixels = data.pitch * pitch_scale_factor

	love.graphics.push()

	love.graphics.setScissor(200,200,400,400)
	love.graphics.translate(love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2)

	local sky = {
		-400, - 1 + pitch_pixels,
		-400, - love.graphics.getHeight() - 50 + pitch_pixels,
		400, - love.graphics.getHeight() - 50 + pitch_pixels,
		400, - 1 + pitch_pixels
	}
	love.graphics.setColor(0.4, 0.4, 1)
	love.graphics.polygon('fill', sky)

	local ground = {
		-400, 1 + pitch_pixels,
		-400, love.graphics.getHeight() + 50 + pitch_pixels,
		400, love.graphics.getHeight() + 50 + pitch_pixels,
		400, 1 + pitch_pixels
	}
	love.graphics.setColor(0.7, 0.5, 0)
	love.graphics.polygon('fill', ground)

	local horizon = {
		-400, 1 + pitch_pixels,
		-400, -1 + pitch_pixels,
		400, -1 + pitch_pixels,
		400, 1 + pitch_pixels
	}
	love.graphics.setColor(1,1,1)
	love.graphics.polygon('fill', horizon)

	love.graphics.setScissor()

	love.graphics.pop()

	-- Debug variable prints
	love.graphics.setColor(1,1,1)
	love.graphics.print("A " .. string.format("%.5f", data.altitude), 20, 20)
	love.graphics.print("S " .. string.format("%.5f", data.ias), 20, 40)
	love.graphics.print("V " .. string.format("%.5f", data.vspeed), 20, 60)
	love.graphics.print("P " .. string.format("%.5f", data.pitch), 200, 20)
	love.graphics.print("R " .. string.format("%.5f", data.roll), 200, 40)
	love.graphics.print("H " .. string.format("%.5f", data.heading), 200, 60)
	-- End debug variable prints
end

