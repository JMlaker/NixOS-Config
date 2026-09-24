{
	description = "Init NixOS flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.11";
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfiguration.joshs-linux = nixpkgs.lib.nixosSystem {
			modules = [
				./configuration.nix
			];
		};
	};
}
