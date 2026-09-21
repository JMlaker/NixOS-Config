{ ... }:
{
	# Don't allow boot to touch EFI so that GRUB can load it
	boot.loader.efi.canTouchEfiVariables = false;
	# Point to EFI partition
	boot.loader.efi.efiSysMountPoint = "/boot/efi";

	# Grub settings
	boot.loader.grub = {
		enable = true;
		efiSupport = true;
		device = "nodev";
		efiInstallAsRemovable = true;
	};

	# Enable btrfs auto scrubbing (to check corrupt files)
	services.btrfs.autoScrub.enable = true;
}
