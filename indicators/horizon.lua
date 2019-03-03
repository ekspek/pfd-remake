local state = require 'state'

return function()
	local pitch_scale_factor = 6
	local pitch = 0
	local heading = 0
	local pitch_pixels = 0

	local intervals = {
		180,
		400,
		800,
		1400,
		2000,
		2300,
		2300 + 1 * 3,
		2300 + 2 * 3,
		2300 + 3 * 3,
		2300 + 4 * 3,
		2300 + 5 * 3,
		2300 + 6 * 3,
		2300 + 7 * 3,
		2300 + 8 * 3,
		2700,
		3000,
	}

	local entity = {}
	
	entity.update = function()
		pitch = state.data.pitch

		-- Pitch check to avoid going overboard
		if pitch > 90 then
			pitch = 90
		elseif pitch < -90 then
			pitch = -90
		end

		-- Heading check to allow for looping
		heading = state.data.heading % 360

		pitch_pixels = pitch * pitch_scale_factor
	end

	entity.draw = function()
		-- Set reference to the center of the screen
		love.graphics.origin()
		love.graphics.translate(love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2)

		-- Push the current reference for using later, as we're creating the artifical horizon next
		love.graphics.push()

		-- Set the scissor for the aritifical horizon display
		love.graphics.setScissor(200,200,400,400)

		-- Rotate the artificial horizon based on roll angle (in radians)
		love.graphics.rotate(state.data.roll)

		-- Defining the points and color for the blue sky rectangle
		local sky = {
			-400, - 1 + pitch_pixels,
			-400, - love.graphics.getHeight() - 50 + pitch_pixels,
			400, - love.graphics.getHeight() - 50 + pitch_pixels,
			400, - 1 + pitch_pixels
		}
		love.graphics.setColor(colors.skyblue)
		love.graphics.polygon('fill', sky)

		-- Defining the points and color for the ground rectangle
		local ground = {
			-400, 1 + pitch_pixels,
			-400, love.graphics.getHeight() + 50 + pitch_pixels,
			400, love.graphics.getHeight() + 50 + pitch_pixels,
			400, 1 + pitch_pixels
		}
		love.graphics.setColor(colors.groundbrown)
		love.graphics.polygon('fill', ground)

		-- Horizon line
		love.graphics.setColor(colors.white)
		love.graphics.setLineWidth(2)
		love.graphics.line(-400, pitch_pixels, 400, pitch_pixels)

		-- Heading indicator on horizon line
		love.graphics.push()

		love.graphics.setColor(colors.white)
		love.graphics.setFont(mono.compasshorizon)

		love.graphics.translate(-heading * 10, pitch_pixels)
		love.graphics.translate(-3600,0)

		-- Three sets of numbers to allow for continuous scrolling
		for i = 1,3 do
			for j = 10,360,10 do
				love.graphics.translate(100, 0)
				love.graphics.print(j / 10, -mono.compasshorizon:getWidth(j / 10) / 2, 0)
			end
		end

		love.graphics.pop()

		-- Pitch lines
		love.graphics.setLineWidth(1)
		love.graphics.setFont(mono.pitch)
		for i = -9,9 do
			-- 10 degree line
			love.graphics.line(-50, -60 * i + pitch_pixels, 50, -60 * i + pitch_pixels)
			if i ~= 0 then
				love.graphics.print(math.abs(i) * 10, 55, -60 * i + pitch_pixels - mono.pitch:getHeight() / 2)
			end
			if i ~= 0 then
				love.graphics.printf(math.abs(i) * 10, -55 - mono.pitch:getWidth(math.abs(i * 10)), -60 * i + pitch_pixels - mono.pitch:getHeight() / 2, mono.pitch:getWidth(math.abs(i * 10)), 'right')
			end

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
		love.graphics.setColor(colors.white)
		love.graphics.polygon('fill', -150, 0, -50, 0, -50, 2, -150, 2)
		love.graphics.polygon('fill', -50, 0, -50, 29, -48, 29, -48, 0)
		love.graphics.polygon('fill', -50, 27, -50, 29, -56, 29, -56, 27)
		love.graphics.polygon('fill', -54, 29, -56, 29, -56, 6, -54, 6)
		love.graphics.polygon('fill', -54, 6, -54, 8, -150, 8, -150, 6)
		love.graphics.polygon('fill', -150, 8, -150, 0, -148, 0, -148, 8)
		love.graphics.setColor(colors.black)
		love.graphics.polygon('fill', -148, 2, -50, 2, -50, 6, -148, 6)
		love.graphics.polygon('fill', -54, 2, -50, 2, -50, 27, -54, 27)

		-- Right HUD wing
		love.graphics.setColor(colors.white)
		love.graphics.polygon('fill', 150, 0, 50, 0, 50, 2, 150, 2)
		love.graphics.polygon('fill', 50, 0, 50, 29, 48, 29, 48, 0)
		love.graphics.polygon('fill', 50, 27, 50, 29, 56, 29, 56, 27)
		love.graphics.polygon('fill', 54, 29, 56, 29, 56, 6, 54, 6)
		love.graphics.polygon('fill', 54, 6, 54, 8, 150, 8, 150, 6)
		love.graphics.polygon('fill', 150, 8, 150, 0, 148, 0, 148, 8)
		love.graphics.setColor(colors.black)
		love.graphics.polygon('fill', 148, 2, 50, 2, 50, 6, 148, 6)
		love.graphics.polygon('fill', 54, 2, 50, 2, 50, 27, 54, 27)

		-- HUD nose
		love.graphics.setColor(colors.white)
		love.graphics.polygon('fill', -5, 0, 5, 0, 5, 10, -5, 10)
		love.graphics.setColor(colors.black)
		love.graphics.polygon('fill', -3, 2, 3, 2, 3, 8, -3, 8)

		-- Final origin reset
		love.graphics.origin()
	end

	return entity
end
