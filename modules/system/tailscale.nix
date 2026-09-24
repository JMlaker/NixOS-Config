# Tailscale service configuration
# Denies all incoming traffic except ssh on tailscale
{ config, ... }:
{
	services.tailscale = {
		enable = true;
	};

	networking.firewall = {
		enable = true;

		allowedUDPPorts = [ config.services.tailscale.port ];

		extraInputRules = ''
			iifname "${config.services.tailscale.interfaceName}" tcp dport 22 accept
		'';
	};
}
