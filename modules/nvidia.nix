{ config, pkgs, ... }:
{
	hardware.graphics.enable = true;
	services.xserver.videoDrivers = [ 
		"amdgpu"
		"nvidia"
	];
	hardware.nvidia.open = true;
	hardware.nvidia.modesetting.enable = true;

	environment.systemPackages = with pkgs; [
		egl-wayland
	];
}
