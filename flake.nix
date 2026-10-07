{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:amaanq/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      ghostty,
      helium,
      neovim-nightly-overlay,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # stow owns parts of ~/.config; move collisions aside instead of failing.
            home-manager.backupFileExtension = "backup";
            home-manager.users.gdmr = import ./home.nix;
          }
          (
            { pkgs, ... }:
            let
              system = pkgs.stdenv.hostPlatform.system;
            in
            {
              nixpkgs.overlays = [
                neovim-nightly-overlay.overlays.default
              ];
              environment.systemPackages = [
                ghostty.packages.${system}.default
                helium.packages.${system}.default
                pkgs.neovim
              ];
            }
          )
        ];
      };
    };
}
