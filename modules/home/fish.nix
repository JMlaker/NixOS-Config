{ lib, pkgs, ... }:
{
	programs.fish = {
		enable = true;

		functions = {
			fish_greeting = "fastfetch";

			fish_prompt = ''
				printf '%s@%s %s%s%s > ' $USER $hostname (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
			'';
		};

		shellAliases = {
			pamcan = "pacman";
			ls = "eza --icons auto";
			l = "ls";
			s = "ls";
			clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
			clc = "clear; fastfetch";
			q = "qs -c ii";
			og = "command";
			please = "eval sudo (history -1)";
		} // lib.optionalAttrs pkgs.stdenv.isDarwin {
      make = "gmake";
    };

		shellAbbrs = {
			vim = "nvim";
			vi = "nvim";
			emacs = "nvim";
			nano = "nvim";
		};

		interactiveShellInit = ''
			set fish_greeting

			[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
		'';
	};
}
