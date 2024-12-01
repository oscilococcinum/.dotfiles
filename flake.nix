{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations.oscilo-srv = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./devices.nix
	./global-pkgs.nix
	./other.nix
	./users.nix
	./nextcloud.nix
	./ssh.nix
      ];
    };
  };
}

