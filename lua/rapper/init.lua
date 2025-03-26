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

M.set_keymaps = function()
	vim.keymap.set(
		"n",
		"j",
		"v:count == 0 ? 'gj' : 'j'",
		{ expr = true, desc = "cursor N lines downward (include 'wrap')" }
	)
	vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "cursor N lines up (include 'wrap')" })
	vim.keymap.set("n", "0", "g0", { desc = "first char of the line (include 'wrap')" })
	vim.keymap.set("n", "^", "g^", { desc = "first non-blank character of the line (include 'wrap')" })
	vim.keymap.set("n", "$", "g$", { desc = "end of the line (include 'wrap')" })
	---------------
	-- NOTE: below changes behavior of Y,D,C to respect line wrap. comment out to have normal behavior. keep in mind you can still achive the same normal behavior just by double tapping. i.e. 'yy' or 'dd'
	vim.keymap.set(
		"n",
		"D",
		"v:count == 0 ? 'dg$' : 'D'",
		{ expr = true, desc = "[D]elete to end of line (include 'wrap')" }
	)
	vim.keymap.set(
		"n",
		"C",
		"v:count == 0 ? 'cg$' : 'C'",
		{ expr = true, desc = "[C]hange to end of line (include 'wrap')" }
	)
	vim.keymap.set(
		"n",
		"Y",
		"v:count == 0 ? 'yg$' : 'y$'",
		{ expr = true, desc = "[Y]ank to end of line (include 'wrap')" }
	)
	---------------
	vim.keymap.set(
		"v",
		"j",
		"v:count == 0 ? 'gj' : 'j'",
		{ expr = true, desc = "cursor N lines downward (include 'wrap')" }
	)
	vim.keymap.set("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "cursor N lines up (include 'wrap')" })
	vim.keymap.set("v", "0", "g0", { desc = "first char of the line (include 'wrap')" })
	vim.keymap.set("v", "^", "g^", { desc = "first non-blank character of the line (include 'wrap')" })
	vim.keymap.set("v", "$", "g$", { desc = "end of the line (include 'wrap')" })
end

M.setup = function()
	vim.api.nvim_create_user_command("Testy", M.toggle_rap, { desc = "Toggle wrap and keymaps" })
end

return M
