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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    { nixpkgs, home-manager, nixvim, zen-browser, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."rpamirov" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	  nixvim.homeModules.nixvim 
          zen-browser.homeModules.beta
	  ./home.nix
	];
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
