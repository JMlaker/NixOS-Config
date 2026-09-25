{ pkgs, ... }:
{
	home.username = "josh";
	home.homeDirectory = 
		if pkgs.stdenv.isDarwin
		then "/Users/josh"
		else "/home/josh";
	
	imports = [
		../../modules/home/kitty.nix
		../../modules/home/fish.nix
		../../modules/home/nvim.nix
	];

	# Do not change this value :3
	home.stateVersion = "26.05";
}
