local Job = require("plenary.job")
-- local config = require("progress.default_config")
local bin = vim.fn.stdpath("data") .. "/lazy/progress.nvim/bin"

local check_syntax = function ()
	local stdout_results = {}

	local job = Job:new {
		command = "ls",
		args = { "." },

		on_stdout = function(_, line)
			table.insert(stdout_results, line)
		end,
	}

	job:sync()
	print(vim.inspect.inspect(stdout_results))
end

local init = function ()
	local config = require('default_config').get_config()
	local conf = {}
	vim.ui.input({ prompt = 'Enter hostname: ' }, function(input)
		conf.hostname = input
	end)
end


init()
check_syntax()
