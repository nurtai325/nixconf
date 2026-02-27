{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      nixpkgs-unstable,
      ... # Add this ellipsis to be safe
    }:
    let
      system = "x86_64-linux";
      # Initialize the unstable package set
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        # This is the "bridge" that makes 'unstable' visible to all modules
        specialArgs = { inherit unstable; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # IMPORTANT: We must also pass 'unstable' into home-manager
            home-manager.extraSpecialArgs = { inherit unstable; };
            home-manager.users.nurtai = {
              imports = [
                nixvim.homeModules.nixvim
                ./home.nix
              ];
            };
          }
        ];
      };
    };
}
