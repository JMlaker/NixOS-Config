{ pkgs, ... }:
{
	imports = [
		./hardware-configuration.nix
		../../users/josh/default.nix
		../../modules/system/common.nix 
    ../../modules/system/claude.nix
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

	networking.hostName = "joshs-linux";
	networking.networkmanager.enable = true;

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
