local theme = require("theme")

local volume_percentage = sbar.add("item", "items.volume_percentage", {
	position = "right",
	padding_right = 5,
	padding_left = 5,
	label = {
		font = {
			size = 10,
		},
	},
})

local volume = sbar.add("item", "items.volume", {
	position = "right",
	padding_left = 5,
	icon = {
		font = {
			family = theme.fonts.icon,
			size = 16,
		},
	},
	update_freq = 120,
})

volume:subscribe({ "volume_change" }, function(envs)
	local value = tonumber(envs.INFO)
	local icon = value == 0 and "󰖁" or value < 30 and "󰕿" or value < 70 and "󰖀" or "󰕾"

	volume:set({
		label = {
			string = icon,
		},
	})

	volume_percentage:set({
		label = {
			string = value .. "%",
		},
	})
end)
