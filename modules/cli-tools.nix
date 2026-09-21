{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		vim # Default editor if nvim isn't available
		neovim
		wget
		git
		tmux
	];
}
