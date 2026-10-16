# modules/home/common.nix
#
# Very similar to modules/system/common.nix but for per-user programs
#
# Enables per-user programs that have little to no config edits
#

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    imagemagick
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
