local icons = require("helpers.icon-map")
local theme = require("theme")

local apps = { "Slack", "Microsoft Outlook" }

sbar.add("item", {
	position = "right",
	padding_right = 10,
})

local function updateNotification(item, app)
	sbar.exec(
		'lsappinfo -all info -only StatusLabel "' .. app .. '" | sed -nr \'s/"StatusLabel"={ "label"="(.+)" }$/\\1/p\'',
		function(notification)
			item:set({
				label = {
					string = notification,
				},
			})
		end
	)
end

for _, app in pairs(apps) do
	local normalized_name, _ = app:lower():gsub(" ", "-")

	local item = sbar.add("item", "notifications." .. normalized_name, {
		position = "right",
		background = {
			padding_left = 5,
			padding_right = 5,
		},
		icon = {
			string = icons[app],
			font = {
				family = theme.fonts.app_icons,
				size = 14,
			},
		},
		label = {
			y_offset = 6,
			padding_left = 3,
			font = {
				size = 10,
			},
		},
		update_freq = 15,
		click_script = "osascript -e 'tell application \"" .. app .. "\" to activate'",
	})

	item:subscribe({ "forced", "routine" }, function()
		updateNotification(item, app)
	end)
end
