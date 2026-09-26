{ pkgs, ... }:
{
	home.username = "josh";
	home.homeDirectory = 
		if pkgs.stdenv.isDarwin
		then "/Users/josh"
		else "/home/josh";
	
	imports = [
    # Default import for per-user programs
    ../../modules/home/common.nix
    
    # Special configs for per-user programs
		../../modules/home/kitty.nix
		../../modules/home/fish.nix
    ../../modules/home/claude.nix
		../../modules/home/nvim.nix
    ../../modules/home/noctalia.nix
	];

	# Do not change this value :3
	home.stateVersion = "26.05";
}
