# modules/system/common.nix
#
# Collection of common system configuration across hosts
#

{ pkgs, ... }:
{
	imports = [
		./ssh.nix
		./tailscale.nix
	];

	# Necessary for this all to work
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	# Default enable garbage collector
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};
	nix.settings.auto-optimise-store = true;

	# Allow fish as a default shell
	programs.fish.enable = true;

	environment.systemPackages = with pkgs; [
		# Text editors
		vim
		neovim

		# Version control
		git

		# Shells
		tcsh

		# Programming languages
		perl
		python3
		tcl

		# HTTP/S requests
		curl
		wget

		# Better UNIX cmds
		htop
		tree
		ripgrep
		fastfetch
		eza
    fd

		# Terminal multiplexer
		tmux

    # Other useful tools
    imagemagick
	];

	# Add global environment variables
	environment.sessionVariables = {
		TERMINAL = "kitty"; # For the rare program that needs it
		EDITOR = "nvim";    # Default editor for many cli tools
	};

	security.sudo.wheelNeedsPassword = true;
	documentation.nixos.enable = false; # Use Google and/or Claude like a gaymer

	services.automatic-timezoned.enable = true;
	i18n.defaultLocale = "en_US.UTF-8";

	system.autoUpgrade.enable = false; # Opt-in behavior for ease of debugging
}
