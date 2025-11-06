{
  description = "Logo's NixOS and Home-Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager (follow nixpkgs)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };

    # plasma-manager input (you already used this)
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Supported systems for your flake packages, formatter
    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    username = "logoes0";
    flakeDir = "/home/${username}/nix-setup";

    # hostVariables must be declared in the 'let' so it's in scope for specialArgs
    hostVariables = {
      browser = "firefox";
      terminal = "konsole";
      # Add other keys your modules expect
    };

  in {
    # overlays (import with access to inputs)
    overlays = import ./overlays { inherit inputs; };

    # packages per system
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # formatter
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # NixOS configuration entrypoint
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        modules = [
          ./system
          nixos-hardware.nixosModules.asus-fx506hm
        ];
        # make these variables available as module args (so modules can accept them)
        specialArgs = {
          inherit username flakeDir inputs outputs hostVariables;
        };
      };
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "${username}@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit username flakeDir inputs outputs hostVariables;
        };
        modules = [ ./home ];
      };
    };
  };
}



# {
#   description = "Logo's NixOS and Home-Manager Flake";
#
#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#     # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
#
#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#
#     stylix.url = "github:danth/stylix";
#
#     nixos-hardware.url = "github:NixOS/nixos-hardware/master";
#
#     betterfox = {
#       url = "github:yokoffing/Betterfox";
#       flake = false;
#     };
#
#     plasma-manager = {
#       url = "github:nix-community/plasma-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#       inputs.home-manager.follows = "home-manager";
#     };
#   };
#
#   outputs = {
#     self,
#     nixpkgs,
#     home-manager,
#     nixos-hardware,
#     ...
#   } @ inputs: let
#     inherit (self) outputs;
#
#     # Supported systems for your flake packages, formatter
#     systems = ["x86_64-linux"];
#     # This is a function that generates an attribute by calling a function you
#     # pass to it, with each system as an argument
#     forAllSystems = nixpkgs.lib.genAttrs systems;
#
#     username = "logoes0";
#     flakeDir = "/home/${username}/nix-setup";
#   in {
#
#     hostVariables = {
#       browser = "firefox";
#       # add any other keys your desktop/defaults.nix uses
#     };
#
#
#     # Your custom packages and modifications, exported as overlays
#     overlays = import ./overlays {inherit inputs;};
#
#     # Your custom packages
#     # Accessible through 'nix build', 'nix shell', etc
#     packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
#
#     # Formatter for your nix files, available through 'nix fmt'
#     # Other options beside 'alejandra' include 'nixpkgs-fmt'
#     formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
#
#     # NixOS configuration entrypoint
#     # Available through 'nixos-rebuild --flake .  [or .#hostname]'
#     nixosConfigurations = {
#       nixos = nixpkgs.lib.nixosSystem {
#         modules = [
#           ./system
#           nixos-hardware.nixosModules.asus-fx506hm
#         ];
#         specialArgs = {
#           inherit username flakeDir inputs outputs hostVariables;
#         };
#       };
#     };
#
#
#     # Standalone home-manager configuration entrypoint
#     # Available through 'home-manager switch --flake .  [ or .#username@hostname]'
#     homeConfigurations = {
#       "${username}@nixos" = home-manager.lib.homeManagerConfiguration {
#         pkgs = nixpkgs.legacyPackages.x86_64-linux;
#         extraSpecialArgs = {
#           inherit username flakeDir inputs outputs hostVariables;
#         };
#         modules = [ ./home ];
#       };
#     };
#   };
# }
