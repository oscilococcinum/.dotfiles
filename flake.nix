{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: {
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

