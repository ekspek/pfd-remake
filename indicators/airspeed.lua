local state = require 'state'

return function()
	local asf = 5 -- Airspeed scale factor - pixel to knot ratio
	local airspeed = {
		val = state.data.ias,
		max = 400,
		d = 0,
		u = 0,
		t = 0,
		h = 0,
	}

	local entity = {}
	local airspeed_pixels = 0

	entity.update = function()
		-- Airspeed check to avoid going over the meter
		if airspeed.val > airspeed.max then
			airspeed.val = airspeed.max
		elseif airspeed.val < 0 then
			airspeed.val = 0
		end

		-- Airspeed scrolling factor
		airspeed_pixels = airspeed.val * asf

		-- Auxiliary variables for hundreds, tenths, units and decimals
		airspeed.h = math.floor(airspeed.val/100)
		airspeed.t = math.floor((airspeed.val - airspeed.h * 100) / 10)
		airspeed.u = math.floor(airspeed.val - airspeed.h * 100 - airspeed.t * 10)
		airspeed.d = airspeed.val - airspeed.h * 100 - airspeed.t * 10 - airspeed.u
	end

	entity.draw = function()
		love.graphics.origin()

		-- Indicator box specifications
		love.graphics.setScissor(50,100,100,600)

		-- Set the origin at the middle of the left edge
		love.graphics.translate(50, 400)
		love.graphics.push() -- Push static middle left reference

		love.graphics.setColor(colors.gray)
		love.graphics.polygon('fill', 0, 350, 75, 350, 75, -350, 0, -350)
	
		love.graphics.translate(75, airspeed_pixels)
		love.graphics.push() -- Push scrolling right zero airspeed reference

		-- If the lower limit is visible (indicator height by pixel to knot ratio)
		if airspeed.val < 700 / asf then
			love.graphics.setColor(1,0,0)
			love.graphics.polygon('fill', 0, 0, 0, 700, -5, 700, -5, 0)
		end

		-- If the upper limit is visible (indicator height by pixel to knot ratio)
		if airspeed.val > airspeed.max - 700 / asf then
			love.graphics.setColor(1,0,0)
			love.graphics.polygon('fill', 0, -400 * asf, 0, -700 * asf, -5, -700 * asf, -5, -400 * asf)
		end

		-- Main ticks and numeric labels
		love.graphics.setColor(colors.white)
		love.graphics.setFont(mono.airspeed)
		for i = 0, airspeed.max, 10 do
			love.graphics.setLineWidth(2)
			love.graphics.line(-10, 0, 0, 0)

			if i%20 == 0 or i == 0 then
				love.graphics.printf(i, -75, -mono.airspeed:getHeight() / 2, 75 - 20, "right")
			end
			love.graphics.translate(0, -10 * asf)
		end

		love.graphics.pop() -- Pop scrolling zero airspeed reference
		love.graphics.setScissor()

		love.graphics.pop() -- Pop static middle left reference
		love.graphics.push() -- Push static middle left reference

		-- Draw fill of current airspeed display
		love.graphics.setColor(colors.black)
		love.graphics.polygon("fill", -40, 40, 60, 40, 60, 10, 70, 0, 60, -10, 60, -40, -40, -40)

		-- Print the text for hundreds and tenths of the current airspeed display
		love.graphics.setColor(colors.white)
		love.graphics.setFont(mono.airspeedbig)
		love.graphics.print(airspeed.t, 22 - mono.airspeedbig:getWidth(0), -mono.airspeedbig:getHeight() / 2)
		love.graphics.print(airspeed.h, 22 - mono.airspeedbig:getWidth(0) * 2, -mono.airspeedbig:getHeight() / 2)

		-- Set crop area for scrolling units number
		love.graphics.setScissor(50 - mono.airspeedbig:getWidth(0) - 22, 400 - 40, mono.airspeedbig:getWidth(0) * 4, 80)

		-- Draw scrolling units number
		love.graphics.translate(22, airspeed.d * mono.airspeedbig:getHeight() - mono.airspeedbig:getHeight() / 2)
		love.graphics.print(airspeed.u)

		love.graphics.translate(0, -2 * mono.airspeedbig:getHeight())
		if airspeed.val < airspeed.max then
			if airspeed.u + 2 >= 10 then
				love.graphics.print(airspeed.u + 2 - 10)
			else
				love.graphics.print(airspeed.u + 2)
			end
		end

		love.graphics.translate(0, mono.airspeedbig:getHeight())
		if airspeed.val < airspeed.max then
			if airspeed.u + 1 >= 10 then
				love.graphics.print(airspeed.u + 1 - 10)
			else
				love.graphics.print(airspeed.u + 1)
			end
		end

		love.graphics.translate(0, 2 * mono.airspeedbig:getHeight())
		if airspeed.val > 1 then
			if airspeed.u + 10 - 1 >= 10 then
				love.graphics.print(airspeed.u - 1)
			else
				love.graphics.print(airspeed.u - 1 + 10)
			end
		end

		love.graphics.translate(0, mono.airspeedbig:getHeight())
		if airspeed.val > 1 then
			if airspeed.u + 10 - 2 >= 10 then
				love.graphics.print(airspeed.u - 2)
			else
				love.graphics.print(airspeed.u - 2 + 10)
			end
		end

		love.graphics.setScissor()

		love.graphics.pop() -- Pop static middle left reference

		-- Draw border of current airspeed display
		love.graphics.setColor(colors.white)
		love.graphics.setLineWidth(2)
		love.graphics.polygon("line", -40, 40, 60, 40, 60, 10, 70, 0, 60, -10, 60, -40, -40, -40)

		love.graphics.setFont(sans.text)
		love.graphics.setColor(colors.lettergreen)
		love.graphics.print("ft/s", 10, 300)
	end

	return entity
end
