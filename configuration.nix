# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/boot.nix
      ./modules/network.nix
      ./modules/users.nix
      ./modules/cli-tools.nix
      ./modules/desktop.nix
      ./modules/nvidia.nix
      ./modules/noctalia.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Never change this :3
  system.stateVersion = "26.11"; # Did you read the comment?

}

