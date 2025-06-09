{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:{
    nixosConfigurations = {
      oscilo-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./devices.nix
          ./global-pkgs.nix
          ./other.nix
          ./users.nix
          ./machine-specific.nix
          ./ollama.nix
        ];
      };
      oscilo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./devices.nix
          ./global-pkgs.nix
          ./other.nix
          ./users.nix
          ./machine-specific.nix
          ./battery.nix
          ./virtualbox.nix
        ];
      };
    };
  };
}

