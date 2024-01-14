return {
	"mfussenegger/nvim-lint",
	opts = {
		formatters_by_ft = {
			["nix"] = { "statix", "nix" },
			["sh"] = { "shellcheck" },
		},
	},
}
