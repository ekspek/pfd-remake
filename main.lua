local state = require 'state'
local indicators = require 'indicators'
local input = require 'input'
local other = require 'other'

function love.load()
end

function love.update(dt)
	for _, indicator in ipairs(indicators) do
		if indicator.update then indicator:update() end
	end

	if other.update then other:update() end

	input.hold()
end

function love.draw()
	for _, indicator in ipairs(indicators) do
		if indicator.draw then indicator:draw() end
	end

	if other.draw then other:draw() end
end

function love.keypressed(key)
	input.press(key)
end

