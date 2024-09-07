{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations.oscilo-envy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./devices.nix
	./global-pkgs.nix
	./other.nix
	./users.nix
      ];
    };
    nixosConfigurations.oscilo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./devices.nix
	./global-pkgs.nix
	./other.nix
	./users.nix
      ];
    };

  };
}

