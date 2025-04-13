local Job = require("plenary.job")
-- local config = require("progress.default_config")

local M

M.check_syntax = function ()
	local stdout_results = {}

	local job = Job:new {
		command = "ls",
		args = { "." },

		on_stdout = function(_, line)
			table.insert(stdout_results, line)
		end,
	}

	job:sync()
	print(vim.inspect(stdout_results))
end

return M
