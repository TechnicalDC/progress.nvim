local defaults = require('progress.defaults').get_config()
local M = {}

M.setup = function (opts)
	local config = opts or defaults
   local dlc = vim.env.DLC
   print(vim.inspect(config))

	-- local conf = {}
	-- vim.ui.input({ prompt = 'Enter hostname: ' }, function(input)
	-- 	conf.hostname = input
	-- end)
end

return M
