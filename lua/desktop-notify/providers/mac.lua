local Job = require("plenary.job")

local M = {}

---@return boolean
function M.should_use_provider()
	return vim.fn.executable("osascript") == 1
end

function M.notify(msg, _)
	Job
		:new({
			command = "osascript",
			args = { "-e", string.format('display notification "%s" with title "Neovim"', msg) },
		})
		:start()
end

return M
