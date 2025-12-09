local theme = require("theme")

sbar.exec("killall stats_provider >/dev/null; stats_provider --cpu usage --memory ram_usage")

local ram_label = sbar.add("item", "ram.label", {
	position = "right",
	padding_right = 10,
	width = 40,
	label = {
		font = {
			size = 10,
		},
	},
})

local ram = sbar.add("graph", "ram", 40, {
	position = "right",
	icon = {
		string = ":ram:",
		font = {
			size = 16,
		},
		padding_right = 5,
	},
	graph = {
		color = theme.colors.medium_gray,
		fill_color = theme.colors.gray,
		line_width = 1,
	},
	y_offset = -2,
	background = {
		height = 20,
		drawing = true,
	},
})

local cpu_label = sbar.add("item", "cpu.label", {
	position = "right",
	padding_right = 10,
	width = 40,
	label = {
		font = {
			size = 10,
		},
	},
})

local cpu = sbar.add("graph", "cpu", 40, {
	position = "right",
	icon = {
		string = ":cpu:",
		font = {
			size = 12,
		},
		padding_right = 5,
	},
	graph = {
		color = theme.colors.medium_gray,
		fill_color = theme.colors.gray,
		line_width = 1,
	},
	background = {
		height = 24,
		drawing = true,
	},
})

ram:subscribe({ "system_stats" }, function(env)
	ram:push({ env.RAM_USAGE:match("(%d+)") / 100 })
	cpu:push({ env.CPU_USAGE:match("(%d+)") / 100 })

	ram_label:set({ label = { string = env.RAM_USAGE } })
	cpu_label:set({ label = { string = env.CPU_USAGE } })
end)
