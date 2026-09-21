{ ... }:
{
	# Define user 'josh'
	users.users.josh = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};
}
