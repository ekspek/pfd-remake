local state = require 'state'
local airspeed = require 'indicators.airspeed'
local altitude = require 'indicators.altitude'
local heading = require 'indicators.heading'
local horizon = require 'indicators.horizon'
local vspeed = require 'indicators.vspeed'

local indicators = {
	airspeed(),
	heading(),
	vspeed(),
	altitude(),
	horizon(),
}

return indicators
