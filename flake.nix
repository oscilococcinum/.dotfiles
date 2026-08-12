{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixvim-module.url = "github:oscilococcinum/nixvim";
    freecad-nix.url = "github:oscilococcinum/freecad-nix";
    zen-browser-nix.url = "github:oscilococcinum/zen-browser-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim-module,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        oscilo-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
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
          specialArgs = { inherit inputs; };
          modules = [
            nixvim-module.nixosModules.default
            ./devices.nix
            ./global-pkgs.nix
            ./other.nix
            ./users.nix
            ./machine-specific.nix
            ./battery.nix
            #./virtualbox.nix
          ];
        };
      };
    };
}
