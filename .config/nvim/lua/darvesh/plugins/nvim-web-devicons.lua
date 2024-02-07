local status, webdevicons = pcall(require, "nvim-web-devicons")
if not status then
	return
end

webdevicons.setup()
