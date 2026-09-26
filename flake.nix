{
	description = "Init NixOS flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations.joshs-linux = nixpkgs.lib.nixosSystem {
			modules = [
				./hosts/joshs-linux/configuration.nix

				home-manager.nixosModules.default
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						extraSpecialArgs = { inherit inputs; };
            backupFileExtension = "bak";
						users.josh = ./users/josh/home.nix;
					};
				}
			];
		};
	};
}
