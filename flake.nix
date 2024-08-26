{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations.oscilo-pc = nixpkgs.lib.nixosSystem {
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

