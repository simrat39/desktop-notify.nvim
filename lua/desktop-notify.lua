local M = {
	current_provider = nil,
	providers = { "desktop-notify/providers/linux" },
}

M.history = {}

function M.notify(msg, level)
	if M.current_provider then
		require(M.current_provider).notify(msg, level)
	else
		for _, value in ipairs(M.providers) do
			local provider = require(value)
			if provider.should_use_provider() then
				M.current_provider = value
				provider.notify(msg, level)
				break
			end
		end
	end

	table.insert(M.history, { msg = msg, level = level })
end

local function level_to_hl(level)
	local hls = {
		[tostring(vim.log.levels.ERROR)] = "NotificationsHistoryUrgent",
		[tostring(vim.log.levels.WARN)] = "NotificationsHistoryWarn",
	}
	return hls[tostring(level)] or "NotificationsHistoryNormal"
end

function M.open_history()
	local ui_height = vim.api.nvim_list_uis()[1].height
	local split_height = #M.history + 1

	if ui_height / 2 < split_height then
		split_height = ui_height / 2
	end

	vim.cmd("split")
	vim.cmd("resize " .. split_height)

	local bufnr = vim.api.nvim_create_buf(false, true)
	local winnr = vim.api.nvim_get_current_win()

	vim.api.nvim_win_set_buf(winnr, bufnr)

	for i, value in ipairs(M.history) do
		local line = i - 1
		vim.api.nvim_buf_set_lines(bufnr, line, line, false, { value.msg })
		vim.api.nvim_buf_add_highlight(bufnr, -1, level_to_hl(value.level), line, 0, -1)
	end
end

function M.override_vim_notify()
	vim.notify = M.notify
end

return M
