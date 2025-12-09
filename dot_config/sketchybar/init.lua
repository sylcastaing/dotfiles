package.cpath = package.cpath .. ";/Users/" .. os.getenv("USER") .. "/.local/share/sketchybar_lua/?.so"

sbar = require("sketchybar")

sbar.begin_config()

sbar.bar({
	height = 30,
	notch_display_height = 33,
	color = "0xff000000",
})

local theme = require("theme")

sbar.default({
	icon = {
		font = {
			family = theme.fonts.app_icons,
			style = "Regular",
			size = 13,
		},
	},
	label = {
		font = {
			family = theme.fonts.text,
			style = "Semibold",
			size = 13,
		},
	},
})

require("items")

sbar.end_config()

sbar.event_loop()
