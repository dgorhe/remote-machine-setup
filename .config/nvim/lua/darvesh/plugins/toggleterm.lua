local status, toggleterm = pcall(require, "toggleterm")
if not status then
	return
end

toggleterm.setup({
	size = 160,
	open_mapping = "<C-_>",
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	persist_size = true,
	direction = "float",
	close_on_exit = false,
	shell = "/bin/bash",
})
