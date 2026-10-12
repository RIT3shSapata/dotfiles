return {
	{
		"3rd/image.nvim",
		build = false,
		opts = {
			-- Use the ImageMagick command-line tools to resize and convert images.
			processor = "magick_cli",

			-- Render images embedded in Markdown files.
			integrations = {
				markdown = {
					enabled = true,
					download_remote_images = true,
					only_render_image_at_cursor = false,
				},
			},

			-- Keep image visibility scoped to the currently active tmux window.
			tmux_show_only_in_active_window = true,
		},
	},
}
