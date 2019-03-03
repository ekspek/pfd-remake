local sans_file = "fonts/B612-Regular.ttf"
local sansbold_file = "fonts/B612-Bold.ttf"
local mono_file = "fonts/B612Mono-Regular.ttf"
local monobold_file = "fonts/B612Mono-Bold.ttf"

local fonts = {}

fonts.sans = {
	normal = love.graphics.newFont(sans_file, 15),
	bold = love.graphics.newFont(sansbold_file, 15),
	label = love.graphics.newFont(sans_file, 15), 
	text = love.graphics.newFont(sans_file, 25), 
	textsmall = love.graphics.newFont(sans_file, 15), 
}

fonts.mono = {
	normal = love.graphics.newFont(mono_file, 15),
	pitch = love.graphics.newFont(mono_file, 15),
	airspeed = love.graphics.newFont(mono_file, 25),
	airspeedbig = love.graphics.newFont(mono_file, 40),
	altitude = love.graphics.newFont(mono_file, 18),
	altitudebig = love.graphics.newFont(mono_file, 35),
	compass = love.graphics.newFont(mono_file, 15),
	compassbig = love.graphics.newFont(monobold_file, 35),
	compasshorizon = love.graphics.newFont(monobold_file, 18),
	vspeed = love.graphics.newFont(monobold_file, 18),
	text = love.graphics.newFont(mono_file, 25),
	textsmall = love.graphics.newFont(mono_file, 15),
}

return fonts
