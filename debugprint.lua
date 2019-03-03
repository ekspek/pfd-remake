local state = require 'state'
local fonts = require 'fonts'

return function()
	local entity = {}

	entity.draw = function()
		love.graphics.setColor(colors.white)
		love.graphics.setFont(fonts.sans.normal)
		love.graphics.print("A " .. string.format("%.5f", state.data.altitude), 20, 20)
		love.graphics.print("S " .. string.format("%.5f", state.data.ias), 20, 20 + fonts.sans.normal:getHeight() + 5)
		love.graphics.print("V " .. string.format("%.5f", state.data.vspeed), 20, 25 + 2 * fonts.sans.normal:getHeight() + 5)
		love.graphics.print("P " .. string.format("%.5f", state.data.pitch), 200, 20)
		love.graphics.print("R " .. string.format("%.5f", state.data.roll * 180 / math.pi), 200, 20 + fonts.sans.normal:getHeight() + 5)
		love.graphics.print("H " .. string.format("%.5f", state.data.heading), 200, 25 + 2 * fonts.sans.normal:getHeight() + 5)
	end

	return entity
end
