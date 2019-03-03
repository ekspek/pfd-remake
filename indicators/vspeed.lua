local state = require 'state'
local fonts = require 'fonts'

return function()
	local vspeed = {
		val = 0,
		capped = 0,
		sf = {70, 40, 7.5},
		sign = 1,
	}

	local entity = {}

	local intervals = {
		300,
		500,
		700,
		1000,
		1300,
		1500,
		1500 + 1 * 2,
		1500 + 2 * 2,
		1500 + 3 * 2,
		1500 + 4 * 2,
		1500 + 5 * 2,
		1500 + 6 * 2,
		1500 + 7 * 2,
		1500 + 8 * 2,
		2000,
		2400,
	}

	entity.getIntervals = function(self)
		return state.data.vspeed, intervals
	end

	entity.update = function(self)
		vspeed.val = state.data.vspeed / 1000 * 60 -- Feet per second to thousands of feet per minute

		if vspeed.val <= 0 then
			vspeed.sign = 1
		else
			vspeed.sign = -1
		end

		if math.abs(vspeed.val) <= 1 then
			vspeed.capped = vspeed.sf[1] * math.abs(vspeed.val)
		elseif math.abs(vspeed.val) <= 2 then
			vspeed.capped = vspeed.sf[1] * 1 + vspeed.sf[2] * (math.abs(vspeed.val) - 1)
		elseif math.abs(vspeed.val) <= 6.5 then
			vspeed.capped = vspeed.sf[1] * 1 + vspeed.sf[2] * 1 + vspeed.sf[3] * (math.abs(vspeed.val) - 2)
		else
			vspeed.capped = vspeed.sf[1] * 1 + vspeed.sf[2] * 1 + vspeed.sf[3] * (6.5 - 2)
		end
	end

	entity.draw = function(self)
		love.graphics.origin()
		love.graphics.translate(love.graphics.getWidth() - 90, love.graphics.getHeight() / 2)

		love.graphics.setColor(state.palette.gray)
		love.graphics.polygon('fill', 60, 100, 40, 150, 0, 150, 0, -150, 40, -150, 60, -100)
		
		love.graphics.translate(30,0)
		love.graphics.push()

		love.graphics.setColor(state.palette.white)
		love.graphics.setLineWidth(4)
		love.graphics.line(-10,0,10,0)
		
		love.graphics.setFont(fonts.mono.vspeed)
		love.graphics.print('0', -25, -fonts.mono.vspeed:getHeight() / 2)

		love.graphics.setColor(state.palette.white)
		love.graphics.setLineWidth(4)

		love.graphics.line(-10,-140,0,-140)
		love.graphics.line(-10,140,0,140)
		love.graphics.print('6', -25, 140 - fonts.mono.vspeed:getHeight() / 2)
		love.graphics.print('6', -25, -140 - fonts.mono.vspeed:getHeight() / 2)

		love.graphics.line(-10,-110,0,-110)
		love.graphics.line(-10,110,0,110)
		love.graphics.print('2', -25, 110 - fonts.mono.vspeed:getHeight() / 2)
		love.graphics.print('2', -25, -110 - fonts.mono.vspeed:getHeight() / 2)

		love.graphics.line(-10,-70,0,-70)
		love.graphics.line(-10,70,0,70)
		love.graphics.print('1', -25, 70 - fonts.mono.vspeed:getHeight() / 2)
		love.graphics.print('1', -25, -70 - fonts.mono.vspeed:getHeight() / 2)

		love.graphics.setLineWidth(2)
		love.graphics.line(-10,-125,0,-125)
		love.graphics.line(-10,125,0,125)
		love.graphics.line(-10,-90,0,-90)
		love.graphics.line(-10,90,0,90)
		love.graphics.line(-10,-35,0,-35)
		love.graphics.line(-10,35,0,35)

		love.graphics.pop()
		love.graphics.translate(30,0)

		love.graphics.setScissor(love.graphics.getWidth() - 90, love.graphics.getHeight() / 2 - 150, 60, 300)

		love.graphics.setLineWidth(4)
		love.graphics.line(-40, vspeed.capped * vspeed.sign, 0, 0)

		love.graphics.setScissor()

		love.graphics.setFont(fonts.sans.textsmall)
		love.graphics.setColor(state.palette.lettergreen)
		love.graphics.print("ft/min", -62, 165)
		love.graphics.print("(x1000)", -62, 185)
	end

	return entity
end
