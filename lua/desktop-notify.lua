local Job = require("plenary.job")

local M = {}

function M.notify(msg, level)
	local l = "low"
	if level == vim.log.levels.WARN then
		l = "normal"
	elseif level == vim.log.levels.ERROR then
		l = "critical"
	end

	Job
		:new({
			command = "notify-send",
			args = { "-u", l, "nvim", msg },
		})
		:start()
end

function M.override_vim_notify()
	vim.notify = M.notify
end

return M
