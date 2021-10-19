local M = {
	current_provider = nil,
	providers = { "desktop-notify/providers/linux", "desktop-notify/providers/mac" },
}

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
end

function M.override_vim_notify()
	vim.notify = M.notify
end

return M
