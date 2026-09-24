{
	description = "Init NixOS flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations.joshs-linux = nixpkgs.lib.nixosSystem {
			modules = [
				./configuration.nix
			];
		};
	};
}
