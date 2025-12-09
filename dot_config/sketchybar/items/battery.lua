local theme = require("theme")

local battery_percentage = sbar.add("item", "items.battery_percentage", {
	position = "right",
	padding_right = 5,
	padding_left = 5,
	label = {
		font = {
			size = 10,
		},
	},
})

local battery = sbar.add("item", "items.battery", {
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

battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = ""
		local label = ""
		local charging = batt_info:find("AC Power") and true or false

		local _, _, charge = batt_info:find("(%d+)%%")
		if charge then
			charge = tonumber(charge)
			label = charge .. "%"
			icon = charging and "󰂄"
				or charge >= 90 and "󰂂"
				or charge >= 80 and "󰂁"
				or charge >= 70 and "󰂀"
				or charge >= 60 and "󰁿"
				or charge >= 50 and "󰁾"
				or charge >= 40 and "󰁽"
				or charge >= 30 and "󰁼"
				or charge >= 20 and "󰁻"
				or "󰁺"
		end

		battery:set({
			icon = {
				string = icon,
			},
		})
		battery_percentage:set({
			label = {
				string = label,
			},
		})
	end)
end)
