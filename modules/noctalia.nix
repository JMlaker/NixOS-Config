{ pkgs, ... }:
{
	# Necessary features
	hardware.bluetooth.enable = false; # Should be true but I'm testing in VM
	services.power-profiles-daemon.enable = true;
	services.upower.enable = true;
}
