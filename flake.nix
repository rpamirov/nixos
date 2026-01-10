{
  description = "rpamirov unified NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, zen-browser, zjstatus, ... }:
  let
    system = "x86_64-linux";

    zjOverlay = final: prev: {
      zjstatus = zjstatus.packages.${system}.default;
    };

    mkHost = hostname: hardware:
      nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          # Host config
          ./machines/${hostname}/default.nix
          hardware

          # Apply overlays + nixpkgs config THE RIGHT WAY
          {
            nixpkgs = {
              overlays = [ zjOverlay ];
              config.allowUnfree = true;
            };
          }

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.rpamirov = {
              imports = [
                nixvim.homeModules.nixvim
                zen-browser.homeModules.beta
                ./home/home.nix
              ];
            };
          }
        ];

        specialArgs = {
          inherit nixvim zen-browser;
        };
      };
  in
  {
    nixosConfigurations = {
      mi-laptop =
        mkHost "mi-laptop"
          ./machines/mi-laptop/hardware-configuration.nix;

      thinkpad-laptop =
        mkHost "thinkpad-laptop"
          ./machines/thinkpad-laptop/hardware-configuration.nix;
    };
  };
}

