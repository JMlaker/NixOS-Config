# modules/system/common.nix
#
# Collection of common system configuration across hosts
#

{ lib, pkgs, ... }:
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
		options = "--delete-older-than 30d";
	}
  // lib.optionalAttrs pkgs.stdenv.isLinux {
    dates = "weekly";
  }
  // lib.optionalAttrs pkgs.stdenv.isDarwin {
    interval = [ { Weekday = 7; Hour = 0; Minute = 0; } ]; 
  };

  nix.settings.auto-optimise-store = !pkgs.stdenv.isDarwin;
  nix.optimise.automatic = true;

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

	system.autoUpgrade.enable = false; # Opt-in behavior for ease of debugging
}
