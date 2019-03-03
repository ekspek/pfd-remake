function altitude_indicator()
	local asf = 0.5 -- Altitude scale factor - pixel to feet ratio
	local altitude = {
		val = state.data.altitude,
		max = 50000,
		min = -1000,
		k = 0,
		h = 0,
		t = 0,
		tp = 0,
	}

	if altitude.val > altitude.max then
		altitude.val = altitude.max
	elseif altitude.val < altitude.min then
		altitude.val = altitude.min
	end

	local altitude_pixels = altitude.val * asf

	love.graphics.origin()
	love.graphics.setScissor(675,100,110,600)
	love.graphics.translate(675,400)
	love.graphics.push()

	love.graphics.setColor(colors.gray)
	love.graphics.polygon('fill', 110, 350, -100, 350, -100, -350, 110, -350)

	love.graphics.translate(0, altitude_pixels)
	love.graphics.push()

	-- If the lower limit is visible (indicator height by pixel to knot ratio)
	if altitude.val < altitude.min + 600 / asf then
		love.graphics.setColor(1,0,0)
		love.graphics.polygon('fill', 0, -altitude.min * asf, 0, -altitude.min * asf + 350, 5, -altitude.min * asf + 350, 5, -altitude.min * asf)
	end

	-- If the lower limit is visible (indicator height by pixel to knot ratio)
	if altitude.val > altitude.max - 600 / asf then
		love.graphics.setColor(1,0,0)
		love.graphics.polygon('fill', 0, -altitude.max * asf, 0, -altitude.max * asf - 350, 5, -altitude.max * asf - 350, 5, -altitude.max * asf)
	end

	for i = -1000,50000,100 do
		if math.abs(altitude.val - i) < 650 then
			love.graphics.setColor(colors.white)
			love.graphics.setLineWidth(1)
			love.graphics.line(10, -i * asf, 0, -i * asf)

			local string = ""
			if i >= 0 then string = ' ' .. i else string = i end

			love.graphics.setFont(mono.altitude)
			love.graphics.printf(string, 15, -0.5 * i - 2 - mono.altitude:getHeight() / 2, 75, 'left')
		end
	end

	love.graphics.pop()
	love.graphics.pop()
	love.graphics.setScissor()
	love.graphics.push()

	-- Draw fill of current airspeed display
	love.graphics.setColor(colors.black)
	love.graphics.polygon("fill", 150, 40, 20, 40, 20, 10, 10, 0, 20, -10, 20, -40, 150, -40)

	-- Auxiliary variables for hundreds, tenths, units and decimals
	altitude.k = math.floor(math.abs(altitude.val)/1000)
	altitude.h = math.floor((math.abs(altitude.val) - altitude.k * 1000) / 100)
	altitude.t = math.floor(math.abs(altitude.val) - altitude.k * 1000 - altitude.h * 100)
	altitude.tp = altitude.t

	if math.fmod(altitude.t, 20) ~= 0 and altitude.t ~= 0 then
		altitude.t = math.floor(altitude.t / 20) * 20
	end

	-- Print the text for hundreds and tenths of the current altitude display
	love.graphics.setColor(colors.white)
	love.graphics.setFont(mono.altitudebig)
	love.graphics.translate(28, -mono.altitudebig:getHeight() / 2)
	if altitude.val < 0 then
		love.graphics.print('-')
		love.graphics.translate(mono.altitudebig:getWidth('-'), 0)
		love.graphics.print(altitude.k, 0, 0)
		love.graphics.translate(mono.altitudebig:getWidth('0'), 0)
	else
		love.graphics.printf(altitude.k, 0, 0, mono.altitudebig:getWidth("00"), 'right')
		love.graphics.translate(mono.altitudebig:getWidth("00"), 0)
	end

	love.graphics.print(altitude.h, 0, 0)

	love.graphics.setScissor(695, 360, 130, 80)

	love.graphics.translate(mono.altitudebig:getWidth('-'), 0)
	love.graphics.push()
	love.graphics.translate(0, 2 * math.fmod(altitude.tp, 20))
	love.graphics.print(string.format("%02d",altitude.t))

	love.graphics.translate(0, -2 * mono.altitudebig:getHeight())
	if altitude.val < altitude.max then
		if altitude.t + 40 >= 100 then
			love.graphics.print(string.format("%02d",altitude.t + 40 - 100))
		else
			love.graphics.print(string.format("%02d",altitude.t + 40))
		end
	end

	love.graphics.translate(0, mono.altitudebig:getHeight())
	if altitude.val < altitude.max then
		if altitude.t + 20 >= 100 then
			love.graphics.print(string.format("%02d",altitude.t + 20 - 100))
		else
			love.graphics.print(string.format("%02d",altitude.t + 20))
		end
	end

	love.graphics.translate(0, 2 * mono.altitudebig:getHeight())
	if altitude.val > altitude.min then
		if altitude.t + 100 - 20 >= 100 then
			love.graphics.print(string.format("%02d",altitude.t - 20))
		else
			love.graphics.print(string.format("%02d",altitude.t + 100 - 20))
		end
	end

	love.graphics.translate(0, mono.altitudebig:getHeight())
	if altitude.val > altitude.min then
		if altitude.t + 100 - 40 >= 100 then
			love.graphics.print(string.format("%02d",altitude.t - 40))
		else
			love.graphics.print(string.format("%02d",altitude.t + 100 - 40))
		end
	end

	love.graphics.pop()
	love.graphics.setScissor()

	love.graphics.pop() -- Pop static middle left reference

	-- Draw border of current airspeed display
	love.graphics.setColor(colors.white)
	love.graphics.setLineWidth(2)
	love.graphics.polygon('line', 150, 40, 20, 40, 20, 10, 10, 0, 20, -10, 20, -40, 150, -40)

	love.graphics.setFont(sans.text)
	love.graphics.setColor(colors.lettergreen)
	love.graphics.print("ft", 110 - 10 - sans.text:getWidth("ft"), 300)
end
