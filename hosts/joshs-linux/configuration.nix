{ pkgs, ... }:
{
	imports = [
		./hardware-configuration.nix
		../../users/josh/default.nix
		../../modules/system/common.nix 
    ../../modules/system/niri.nix
	];

	# Boot loader configs
	boot.loader = {
		# Allow GRUB to manage EFI
		efi = {
			canTouchEfiVariables = false;
			efiSysMountPoint = "/boot/efi";
		};

		# Use GRUB as boot loader
		grub = {
			enable = true;
			efiSupport = true;
			device = "nodev";
			# Removable EFI allows for QEMU booting
			efiInstallAsRemovable = true;
		};
	};

	# btrfs auto scrub checks for corrupt files (and repairs if RAID)
	services.btrfs.autoScrub.enable = true;

  # Require password for NixOS sudo
	security.sudo.wheelNeedsPassword = true;

  # Disable nixos documentation (saves small amount of space)
  documentation.nixos.enable = false;

  # Default locale loaded into /etc/locale.conf
  i18n.defaultLocale = "en_US.UTF-8";

  # Hostname (same as directory name)
	networking.hostName = "joshs-linux";
  # Enable networkmanager for Wi-Fi
	networking.networkmanager.enable = true;

  # Let timezone be automatically determined (for laptops mostly)
	services.automatic-timezoned.enable = true;

  # Services that are useful to configure for laptops
  hardware.bluetooth.enable = false;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

	# This laptop has Nvidia D/AMD I dual graphics
	hardware.graphics.enable = true;
	services.xserver.videoDrivers = [
		"amdgpu"
		"nvidia"
	];
	hardware.nvidia = {
		open = true;
		modesetting.enable = true;
	};

	environment.systemPackages = with pkgs; [
		egl-wayland
	];

	# Never change this :3
	system.stateVersion = "26.11";
}
