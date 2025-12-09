local icons = require("helpers.icon-map")
local theme = require("theme")

local function updateSpace(workspaceId, space)
	sbar.exec(
		'aerospace list-workspaces --all --json --format "%{workspace}%{monitor-appkit-nsscreen-screens-id}%{workspace-is-focused}%{workspace-is-visible}"',
		function(workspaces)
			for _, workspace in pairs(workspaces) do
				if workspace.workspace == workspaceId then
					sbar.exec("aerospace list-windows --workspace " .. workspaceId .. " --json", function(windows)
						local hasWindows = #windows > 0
						local isVisible = workspace["workspace-is-visible"]
						local display = workspace["monitor-appkit-nsscreen-screens-id"]

						local drawing = isVisible or hasWindows
						local color = isVisible and theme.colors.white or theme.colors.medium_gray

						local workspaceIcons = ""

						if drawing then
							for _, window in pairs(windows) do
								workspaceIcons = workspaceIcons .. (icons[window["app-name"]] or "")
							end
						end

						space:set({
							drawing = drawing,
							display = display,
							icon = {
								string = workspaceId,
								font = {
									family = theme.fonts.text,
									style = "Semibold",
									size = 11.0,
								},
								color = color,
								padding_left = 5,
								padding_right = 4,
							},
							label = {
								string = workspaceIcons,
								font = {
									family = theme.fonts.app_icons,
									style = "Regular",
									size = 11.0,
								},
								color = color,
								padding_left = 2,
								padding_right = 5,
							},
							background = {
								height = 20,
								corner_radius = 6,
								padding_left = -10,
								padding_right = 15,
								color = theme.colors.gray,
							},
							click_script = "aerospace workspace " .. workspaceId,
						})
					end)

					break
				end
			end
		end
	)
end

sbar.exec("aerospace list-workspaces --all --json", function(workspaces)
	for i, workspace in pairs(workspaces) do
		local workspaceId = workspace.workspace

		local space = sbar.add("item", "space" .. workspaceId, {
			drawing = false,
		})

		updateSpace(workspaceId, space)

		space:subscribe(
			{ "forced", "aerospace_workspace_change", "space_windows_change", "display_change", "system_woke" },
			function()
				updateSpace(workspaceId, space)
			end
		)
	end
end)
