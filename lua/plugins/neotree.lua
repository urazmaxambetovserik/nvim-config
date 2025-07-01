--- @class IconRule
--- @field ends_with string | nil
--- @field icon string
--- @field full_match string | nil
--- @field color string | nil

--- @type List<IconRule>
local icon_rules = {
	{ ends_with = ".ftl", icon = "󰗊" },
	{ color = "#048cda", ends_with = ".controller.ts", icon = "" },
	{ ends_with = ".e2e-spec.ts", icon = "󰙨" },
	{ full_match = "docker-compose.test.yml", icon = "󰡨" },
	{ color = "#8B5CF6", ends_with = ".repository.ts", icon = "" },
	{ color = "#f3c13e", ends_with = ".service.ts", icon = "" },
	{ color = "#f3c13e", ends_with = ".provider.ts", icon = "" },
	{ color = "#3fa843", ends_with = ".guard.ts", icon = "" },
	{ color = "#eb3834", ends_with = ".module.ts", icon = "" },
	{ color = "#ff9312", ends_with = ".interceptor.ts", icon = "" },
	{ color = "#ddf9c1", ends_with = ".dto.ts", icon = "" },
	{ color = "#008576", ends_with = ".pipe.ts", icon = "" },
	{ color = "#5868c0", ends_with = ".middleware.ts", icon = "" },
	{ color = "#e76f51", ends_with = ".util.ts", icon = "" },
	{ color = "#8ecae6", ends_with = ".interface.ts", icon = "" },
	{ color = "#c053d4", ends_with = ".decorator.ts", icon = "" },
	{ color = "#c1121f", ends_with = ".exception.ts", icon = "" },
	{ color = "#0f0", ends_with = ".validator.ts", icon = "" },
	{ color = "#e76f51", ends_with = ".filter.ts", icon = "" },
	{ color = "#3ea1c8", icon = "", full_match = "yarn.lock" },
	{ color = "#c94823", icon = "", full_match = "jest.config.ts" },
	{ color = "#eb3834", icon = "", full_match = "nest-cli.json" },
	{ color = "#f3c13e", icon = "", full_match = "jest.preset.js" },
	{ color = "#048cda", ends_with = ".controller.spec.ts", icon = "󰙨" },
	{ color = "#f3c13e", ends_with = ".service.spec.ts", icon = "󰙨" },
	{ icon = "󱣴", full_match = "splash_screen.yaml" },
	{ color = "#ffffff", icon = "󰗊", full_match = "slang.yaml" },
	{ color = "#048cda", icon = "󰟌", full_match = "analysis_options.yaml" },
	{ icon = "", ends_with = "i18n.json" },
	{ icon = "", ends_with = ".g.dart" },
	{ icon = "", ends_with = ".freezed.dart" },
	{ icon = "", ends_with = ".gr.dart" },
	{ icon = "", full_match = "requirements.txt" },
	{ icon = "󰩃", color = "#f8b344", ends_with = ".proto" },
}

-- Функция для преобразования строки в Паскаль-кейс
local function to_pascal_case(str)
	return (str:gsub("([_%w])", function(c)
		return c:upper()
	end):gsub("^[a-z]", string.upper))
end

-- Перебор правил и создание highlight групп
for _, rule in ipairs(icon_rules) do
	if rule.color then
		local group_name = "CustomHighlight" .. to_pascal_case(rule.ends_with or rule.full_match)

		local highlight_command = string.format(":highlight %s guifg=%s", group_name, rule.color)
		vim.cmd(highlight_command)
	end
end

local function get_icon_and_hl(name)
	for _, rule in ipairs(icon_rules) do
		if
			(rule.ends_with and name:sub(-#rule.ends_with) == rule.ends_with)
			or (rule.full_match and name == rule.full_match)
		then
			-- Генерируем имя группы с префиксом Nest и ends_with в паскаль-кейсе
			if not rule.color then
				return rule.icon, nil
			end
			return rule.icon, "CustomHighlight" .. to_pascal_case(rule.ends_with or rule.full_match)
		end
	end

	return nil, nil -- Если не найдено, возвращаем nil
end

require("neo-tree").setup({
	default_component_configs = {
		icon = {
			provider = function(icon, node, state)
				if node.type == "file" or node.type == "terminal" then
					local success, web_devicons = pcall(require, "nvim-web-devicons")
					--- @type string
					local name = node.type == "terminal" and "terminal" or node.name

					if success then
						local devicon, hl = web_devicons.get_icon(name)
						local custom_icon, custom_hl = get_icon_and_hl(name)

						icon.text = custom_icon or devicon or icon.text

						icon.highlight = custom_hl or hl or icon.highlight
					end
				end
			end,
		},
	},
	filesystem = {
		filtered_items = {
			hide_by_name = {
				"build",
				"android",
				"pubspec.lock",
				"node_modules",
				"dist",
				"__init__.py",
			},
			hide_by_pattern = {
				"*.freezed.dart",
				"*.g.dart",
				"*.chopper.dart",
			},
			show_hidden_count = false,
		},
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(arg)
				vim.opt.relativenumber = true
				vim.opt.number = true
				vim.opt.cursorline = true
			end,
		},
	},
})
