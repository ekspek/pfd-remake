local data = {
	altitude = 0,
	ias = 0,
	vspeed = 0,
	pitch = 0,
	roll = 0,
	heading = 0,
}

local pitchmax = 90
local rollmax = 90

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
	--if roll_left then data.roll = data.roll + math.pi / 180 else data.roll = data.roll - math.pi / 180 end
	data.roll = 10 * math.pi / 180
end

function love.draw()
	local pitch_scale_factor = 6
	local pitch_pixels = data.pitch * pitch_scale_factor

	-- Set reference to the center of the screen
	love.graphics.translate(love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2)

	-- Push the current reference for using later, as we're creating the artifical horizon next
	love.graphics.push()

	-- Set the scissor for the aritifical horizon display
	love.graphics.setScissor(200,200,400,400)

	-- Rotate the artificial horizon based on roll angle (in radians)
	love.graphics.rotate(data.roll)

	-- Defining the points and color for the blue sky rectangle
	local sky = {
		-400, - 1 + pitch_pixels,
		-400, - love.graphics.getHeight() - 50 + pitch_pixels,
		400, - love.graphics.getHeight() - 50 + pitch_pixels,
		400, - 1 + pitch_pixels
	}
	love.graphics.setColor(0.4, 0.4, 1)
	love.graphics.polygon('fill', sky)

	-- Defining the points and color for the ground rectangle
	local ground = {
		-400, 1 + pitch_pixels,
		-400, love.graphics.getHeight() + 50 + pitch_pixels,
		400, love.graphics.getHeight() + 50 + pitch_pixels,
		400, 1 + pitch_pixels
	}
	love.graphics.setColor(0.7, 0.5, 0)
	love.graphics.polygon('fill', ground)

	-- Horizon line
	local horizon = {
		-400, 1 + pitch_pixels,
		-400, -1 + pitch_pixels,
		400, -1 + pitch_pixels,
		400, 1 + pitch_pixels
	}
	love.graphics.setColor(1,1,1)
	love.graphics.polygon('fill', horizon)

	-- Pitch lines
	love.graphics.setFont(sans_label)
	for i = -9,9 do
		-- 10 degree line
		love.graphics.line(-50, -60 * i + pitch_pixels, 50, -60 * i + pitch_pixels)
		if i ~= 0 then love.graphics.print(math.abs(i) * 10, 55, -60 * i + pitch_pixels - sans_label:getHeight() / 2) end

		if i ~= -9 then
			-- 5 degree line
			love.graphics.line(-25, -60 * i + 30 + pitch_pixels, 25, -60 * i + 30 + pitch_pixels)

			-- 2.5 degree lines
			love.graphics.line(-10, -60 * i + 15 + pitch_pixels, 10, -60 * i + 15 + pitch_pixels)
			love.graphics.line(-10, -60 * i + 45 + pitch_pixels, 10, -60 * i + 45 + pitch_pixels)
		end
	end
	love.graphics.setFont(sans)

	-- Resetting the reference
	love.graphics.setScissor()
	love.graphics.pop()

	-- Left HUD wing
	love.graphics.setColor(1,1,1)
	love.graphics.polygon('fill', -150, 0, -50, 0, -50, 2, -150, 2)
	love.graphics.polygon('fill', -50, 0, -50, 29, -48, 29, -48, 0)
	love.graphics.polygon('fill', -50, 27, -50, 29, -56, 29, -56, 27)
	love.graphics.polygon('fill', -54, 29, -56, 29, -56, 6, -54, 6)
	love.graphics.polygon('fill', -54, 6, -54, 8, -150, 8, -150, 6)
	love.graphics.polygon('fill', -150, 8, -150, 0, -148, 0, -148, 8)
	love.graphics.setColor(0,0,0)
	love.graphics.polygon('fill', -148, 2, -50, 2, -50, 6, -148, 6)
	love.graphics.polygon('fill', -54, 2, -50, 2, -50, 27, -54, 27)

	-- Right HUD wing
	love.graphics.setColor(1,1,1)
	love.graphics.polygon('fill', 150, 0, 50, 0, 50, 2, 150, 2)
	love.graphics.polygon('fill', 50, 0, 50, 29, 48, 29, 48, 0)
	love.graphics.polygon('fill', 50, 27, 50, 29, 56, 29, 56, 27)
	love.graphics.polygon('fill', 54, 29, 56, 29, 56, 6, 54, 6)
	love.graphics.polygon('fill', 54, 6, 54, 8, 150, 8, 150, 6)
	love.graphics.polygon('fill', 150, 8, 150, 0, 148, 0, 148, 8)
	love.graphics.setColor(0,0,0)
	love.graphics.polygon('fill', 148, 2, 50, 2, 50, 6, 148, 6)
	love.graphics.polygon('fill', 54, 2, 50, 2, 50, 27, 54, 27)

	-- HUD nose
	love.graphics.setColor(1,1,1)
	love.graphics.polygon('fill', -5, 0, 5, 0, 5, 10, -5, 10)
	love.graphics.setColor(0,0,0)
	love.graphics.polygon('fill', -3, 2, 3, 2, 3, 8, -3, 8)

	-- Debug variable prints
	love.graphics.origin()
	love.graphics.setColor(1,1,1)
	love.graphics.setFont(sans)
	love.graphics.print("A " .. string.format("%.5f", data.altitude), 20, 20)
	love.graphics.print("S " .. string.format("%.5f", data.ias), 20, 20 + sans:getHeight() + 5)
	love.graphics.print("V " .. string.format("%.5f", data.vspeed), 20, 25 + 2 * sans:getHeight() + 5)
	love.graphics.print("P " .. string.format("%.5f", data.pitch), 200, 20)
	love.graphics.print("R " .. string.format("%.5f", data.roll), 200, 20 + sans:getHeight() + 5)
	love.graphics.print("H " .. string.format("%.5f", data.heading), 200, 25 + 2 * sans:getHeight() + 5)
	-- End debug variable prints
end

