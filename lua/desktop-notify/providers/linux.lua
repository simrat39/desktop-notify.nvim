local Job = require("plenary.job")

local M = {}

---@return boolean
function M.should_use_provider()
	return vim.fn.executable("notify-send") == 1
end

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

return M
