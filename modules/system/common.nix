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

	# Enable garbage collector
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};
	nix.settings.auto-optimise-store = true;

	# Allow fish as a default shell
	programs.fish.enable = true;

  # System packages
	environment.systemPackages = with pkgs; [
		# Text editors
		vim
 	  neovim

		# Version control
		git

		# Shells
		tcsh

		# General use programming languages
    # for ad-hoc programming
		perl
		python3
		tcl
    gnumake
    gcc

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
    screen

    # Other useful tools
    podman
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

  hardware.bluetooth.enable = false;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

	system.autoUpgrade.enable = false; # Opt-in behavior for ease of debugging
}
