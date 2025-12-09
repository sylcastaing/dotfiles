local theme = require("theme")

local clock = sbar.add("item", "clock", {
	position = "right",
	background = {
		padding_left = 5,
		padding_right = -5,
	},
	icon = {
		padding_right = 5,
		font = {
			family = theme.fonts.text,
			style = "bold",
			size = 12,
		},
	},
	label = {
		font = {
			size = 12,
		},
	},
	update_freq = 10,
})

clock:subscribe({ "forced", "routine", "system_woke" }, function()
	clock:set({
		icon = {
			string = os.date("%a %b %d"),
		},
		label = {
			string = os.date("%H:%M"),
		},
	})
end)
