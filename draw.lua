function debug_variables()
	love.graphics.setColor(1,1,1)
	love.graphics.setFont(sans)
	love.graphics.print("A " .. string.format("%.5f", data.altitude), 20, 20)
	love.graphics.print("S " .. string.format("%.5f", data.ias), 20, 20 + sans:getHeight() + 5)
	love.graphics.print("V " .. string.format("%.5f", data.vspeed), 20, 25 + 2 * sans:getHeight() + 5)
	love.graphics.print("P " .. string.format("%.5f", data.pitch), 200, 20)
	love.graphics.print("R " .. string.format("%.5f", data.roll * 180 / math.pi), 200, 20 + sans:getHeight() + 5)
	love.graphics.print("H " .. string.format("%.5f", data.heading), 200, 25 + 2 * sans:getHeight() + 5)
end

function artificial_horizon()
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
	love.graphics.setColor(1,1,1)
	love.graphics.setLineWidth(2)
	love.graphics.line(-400, pitch_pixels, 400, pitch_pixels)

	-- Pitch lines
	love.graphics.setLineWidth(1)
	love.graphics.setFont(mono_pitch)
	for i = -9,9 do
		-- 10 degree line
		love.graphics.line(-50, -60 * i + pitch_pixels, 50, -60 * i + pitch_pixels)
		if i ~= 0 then love.graphics.print(math.abs(i) * 10, 55, -60 * i + pitch_pixels - mono_pitch:getHeight() / 2) end

		if i ~= -9 then
			-- 5 degree line
			love.graphics.line(-25, -60 * i + 30 + pitch_pixels, 25, -60 * i + 30 + pitch_pixels)

			-- 2.5 degree lines
			love.graphics.line(-10, -60 * i + 15 + pitch_pixels, 10, -60 * i + 15 + pitch_pixels)
			love.graphics.line(-10, -60 * i + 45 + pitch_pixels, 10, -60 * i + 45 + pitch_pixels)
		end
	end

	-- Current roll pointer
	love.graphics.translate(0, -200)
	love.graphics.polygon('fill', -10, 20, 10, 20, 0, 10)

	-- Resetting the reference
	love.graphics.setScissor()
	love.graphics.pop()

	-- Zero roll pointer
	love.graphics.push()
	love.graphics.translate(0, -200)
	love.graphics.polygon('fill', -10, 0, 10, 0, 0, 10)

	-- Roll pointers
	-- 10 and 20 degree pointers
	for i = -2,2 do
		if i ~= 0 then
			love.graphics.pop()
			love.graphics.push()

			local rollind_length = 10
			love.graphics.rotate(i * 10 * math.pi / 180)
			love.graphics.translate(0, -190)
			love.graphics.line(0, 0, 0, -rollind_length)
		end
	end

	-- 30 and 60 degree pointers
	for i = -2,2 do
		if i ~= 0 then
			love.graphics.pop()
			love.graphics.push()

			local rollind_length = 20
			love.graphics.rotate(i * 30 * math.pi / 180)
			love.graphics.translate(0, -190)
			love.graphics.line(0, 0, 0, -rollind_length)
		end
	end

	-- 45 degree pointers
	for i = -1,1 do
		if i ~= 0 then
			love.graphics.pop()
			love.graphics.push()

			local rollind_length = 10
			love.graphics.rotate(i * 45 * math.pi / 180)
			love.graphics.translate(0, -190)
			love.graphics.line(0, 0, 0, -rollind_length)
		end
	end

	-- Resetting the reference
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

	-- Final origin reset
	love.graphics.origin()
end

function airspeed_meter()
	local airspeed_max = 400
	local asf = 5 -- Airspeed scale factor - pixel to knot ratio
	local airspeed = data.ias -- Set a local variable to change

	-- Airspeed check to avoid going over the meter
	if airspeed > airspeed_max then
		airspeed = airspeed_max
	elseif airspeed < 0 then
		airspeed = 0
	end

	-- Airspeed scrolling factor
	local airspeed_pixels = airspeed * asf

	love.graphics.origin()

	-- Indicator box specifications
	love.graphics.setScissor(50,100,100,600)

	-- Set the origin at the middle of the left edge
	love.graphics.translate(50, 400)
	love.graphics.push() -- Push static middle left reference

	love.graphics.setColor(0.47, 0.47, 0.47)
	love.graphics.polygon('fill', 0, 350, 75, 350, 75, -350, 0, -350)

	love.graphics.translate(75, airspeed_pixels)
	love.graphics.push() -- Push scrolling right zero airspeed reference
	
	-- If the lower limit is visible (indicator height by pixel to knot ratio)
	if airspeed < 700 / asf then
		love.graphics.setColor(1,0,0)
		love.graphics.polygon('fill', 0, 0, 0, 700, -5, 700, -5, 0)
	end

	-- If the upper limit is visible (indicator height by pixel to knot ratio)
	if airspeed > airspeed_max - 700 / asf then
		love.graphics.setColor(1,0,0)
		love.graphics.polygon('fill', 0, -400 * asf, 0, -700 * asf, -5, -700 * asf, -5, -400 * asf)
	end

	-- Main ticks and numeric labels
	love.graphics.setColor(1,1,1)
	love.graphics.setFont(mono_airspeed)
	for i = 0, airspeed_max, 10 do
		love.graphics.setLineWidth(2)
		love.graphics.line(-10, 0, 0, 0)

		if i%20 == 0 or i == 0 then
			love.graphics.printf(i, -75, -mono_airspeed:getHeight() / 2, 75 - 20, "right")
		end
		love.graphics.translate(0, -10 * asf)
	end

	love.graphics.pop() -- Pop scrolling zero airspeed reference
	love.graphics.setScissor()

	love.graphics.pop() -- Pop static middle left reference

	love.graphics.setColor(0,0,0)
	love.graphics.polygon("fill", -40, 40, 60, 40, 60, 10, 70, 0, 60, -10, 60, -40, -40, -40)
	love.graphics.setColor(1,1,1)
	love.graphics.setLineWidth(2)
	love.graphics.polygon("line", -40, 40, 60, 40, 60, 10, 70, 0, 60, -10, 60, -40, -40, -40)
end
