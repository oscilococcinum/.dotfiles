{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixvim-module.url = "github:oscilococcinum/nixvim";
  };

  outputs = { self, nixpkgs, nixvim-module }:{
    nixosConfigurations = {
      oscilo-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixvim-module.nixosModules.default
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
          nixvim-module.nixosModules.default
          ./devices.nix
          ./global-pkgs.nix
          ./other.nix
          ./users.nix
          ./machine-specific.nix
          ./battery.nix
#          ./virtualbox.nix
        ];
      };
    };
  };
}

