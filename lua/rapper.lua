M = {}

M.test = function()
	print("===")
	print("hello from lua/")
	print("===")
end

M.toggle_rap = function()
	-- set notification
	local ok, fidget = pcall(require, "fidget")
	if ok then
		vim.notify = fidget.notify
	end

	---@diagnostic disable-next-line: undefined-field
	local wrap = vim.opt_global.wrap:get()
	local cur_win_nr = vim.fn.winnr()

	if wrap then
		-- toggle wrap off and keymaps
		vim.cmd("set nowrap nolinebreak formatoptions+=l") -- set for future buffers
		vim.cmd("windo set nowrap nolinebreak formatoptions+=l") -- set for cur windo
		vim.cmd(cur_win_nr .. "wincmd w")
		vim.notify("❌ Rap disabled")
	else
		-- toggle wrap on & keymaps
		vim.cmd("set wrap linebreak formatoptions-=l")
		vim.cmd("windo set wrap linebreak formatoptions-=l")
		vim.cmd(cur_win_nr .. "wincmd w")
		vim.notify("✅ Rap enabled")
	end
end

M.setup = function()
	vim.api.nvim_create_user_command("Testy", M.toggle_rap, { desc = "Toggle wrap and keymaps" })
end

return M
