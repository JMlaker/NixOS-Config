{ pkgs, ... }:
{
	programs.kitty = {
		enable = true;

		font = {
			name = "JetBrainsMono Nerd Font";
			size = 11;
		};

		themeFile = "Catppuccin-Macchiato";

		enableGitIntegration = true;
		
		shellIntegration.enableFishIntegration = true;

		settings = {
			cursor_shape = "beam";
			cursor_trail = 3;
			shell = "fish";
			editor = "nvim";
			enabled_layouts = "tall";
		};
	};
}
