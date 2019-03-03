local state = require 'state'
local indicators = require 'indicators'
local input = require 'input'

function love.load()
end

function love.update(dt)
	for _, indicator in ipairs(indicators) do
		if indicator.update then indicator:update() end
	end

	input.hold()
end

function love.draw()
	for _, indicator in ipairs(indicators) do
		if indicator.draw then indicator:draw() end
	end

	--[[
	if strings.toprint and strings[strings.numtoprint] then
		love.graphics.origin()
		love.graphics.setColor(colors.white)
		love.graphics.setFont(sans.normal)
		love.graphics.printf(strings[strings.numtoprint], 400, 20, love.graphics.getWidth() - 420, 'left')
	end
	--]]
end

function love.keypressed(key)
	input.press(key)
end

