local state = require 'state'
local airspeed = require 'indicators.airspeed'

local indicators = {
	airspeed(),
}

return indicators
