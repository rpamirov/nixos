{
  description = "Home Manager configuration of rpamirov";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      zen-browser,
      zjstatus,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            zjstatus = zjstatus.packages.${system}.default;
          })
        ];
      };
    in
    {
      homeConfigurations.rpamirov = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nixvim.homeModules.nixvim
          zen-browser.homeModules.beta
          ./home.nix
        ];
      };
    };
}
