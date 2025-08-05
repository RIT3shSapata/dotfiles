-- lazy.nvim
return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				picker = true,
				---@class snacks.picker.sources.Config
				sources = {
					files = {
						hidden = true, -- show hidden files
						follow = true,
						ignored = true,
					},
					explorer = {
						hidden = true, -- show hidden files
						follow = true,
						ignored = true,
					},
				},
			},
		},
	},
}
