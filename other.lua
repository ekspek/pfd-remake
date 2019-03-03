local state = require 'state'
local indicators = require 'indicators'
local fonts = require 'fonts'

local entity = {}

local strings = {
	"This is deliberate. The meter is not supposed to go this far up, but the data received can.",
	"OK, you can stop it now. Turn around.",
	"The display is stuck. It's not funny anymore.",
	"I hate you.",
	"Fine. Let's play a game.",
	"Ha, you had to go back to read these!",
	"They're full of nothing, but they're still funny.",
	"Maybe I should have thrown the Navy Seal copypasta in here.",
	"What?",
	"Why did I write all this stuff?",
	"I don't really know.",
	"It's good Lua practice though, so there's that.",
	"So thanks for that.",
	"Yeah, bet you feel real silly right now.",
	"There's nothing else left.",
	"Really, you can check the code.",
	toprint = false,
	numtoprint = 0,
}

local function surprise(var, intervals)
	if var < intervals[1] then
		strings.toprint = false
		strings.numtoprint = 0
	else
		for i = 1, #intervals do
			if intervals[i+1] then
				if var >= intervals[i] and var < intervals[i+1] then
					strings.numtoprint = i
				end
			else
				if var >= intervals[i] then
					strings.numtoprint = i
				end
			end
		end
		strings.toprint = true
	end
end

entity.update = function(self)
	for _, indicator in ipairs(indicators) do
		if indicator.getIntervals then
			surprise(indicator:getIntervals())
		end
	end
end

entity.draw = function(self)
	if strings.toprint and strings[strings.numtoprint] then
		love.graphics.origin()
		love.graphics.setColor(state.palette.white)
		love.graphics.setFont(fonts.sans.normal)
		love.graphics.printf(strings[strings.numtoprint], 400, 20, love.graphics.getWidth() - 420, 'left')
	end
end

return entity
