local state = require 'state'
local fonts = require 'fonts'

return function()
	local radius = 200
	local dirs = {[90] = 'E', [180] = 'S', [270] = 'W', [360] = 'N'}
	local heading = 0

	local entity = {}

	entity.update = function()
		heading = state.data.heading
	end

	entity.draw = function()
		love.graphics.origin()

		love.graphics.translate(love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() + 50)
		love.graphics.push()

		love.graphics.setColor(0,0,0.8)
		love.graphics.arc('fill', 0, 0, radius, 0, -math.pi, 50)
		love.graphics.setColor(0,0,0.4)
		love.graphics.arc('fill', 0, 0, radius - 10, 0, -math.pi, 50)
		love.graphics.setColor(0,0,0.2)
		love.graphics.arc('fill', 0, 0, radius - 27, 0, -math.pi, 50)
		love.graphics.setColor(colors.black)
		love.graphics.arc('fill', 0, 0, radius - 45, 0, -math.pi, 50)
		love.graphics.setColor(colors.white)
		love.graphics.arc('line', 0, 0, radius, 0, -math.pi, 50)

		love.graphics.rotate(-heading * math.pi / 180)
		for i = 1,360 do
			love.graphics.rotate(math.pi / 180)

			if i%10 == 0 then
				love.graphics.setColor(colors.white)
				love.graphics.setLineWidth(1)
				love.graphics.line(0,-radius,0,-radius + 10)

				if not dirs[i] then
					love.graphics.setFont(fonts.mono.compass)
					love.graphics.print(i/10, -fonts.mono.compass:getWidth(i/10) / 2, -radius + 10)
				end
			elseif i%5 == 0 then
				love.graphics.setColor(colors.white)
				love.graphics.setLineWidth(1)
				love.graphics.line(0,-radius,0,-radius + 5)
			end

			if dirs[i] then
				love.graphics.setColor(colors.white)
				love.graphics.setFont(fonts.mono.compassbig)
				love.graphics.print(dirs[i], -fonts.mono.compassbig:getWidth(dirs[i]) / 2, -radius + 5)
			end
		end

		love.graphics.pop()

		love.graphics.translate(0, -radius + 9)
		love.graphics.setColor(colors.white)
		love.graphics.polygon('fill', 0, 0, -15, -20, 15, -20)
		love.graphics.setColor(1,0,0)
		love.graphics.polygon('fill', 0, -4, -10, -18, 10, -18)
	end

	return entity
end
