{ ... }:
{
	# Host Name
	networking.hostName = "joshs-linux";
	networking.networkmanager.enable = true;

	# Timezone
	services.automatic-timezoned.enable = true;

	# Locale
	i18n.defaultLocale = "en_US.UTF-8";
}
