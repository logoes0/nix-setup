{
  outputs,
  config,
  pkgs,
  username,
  flakeDir,
  ...
}: {
  imports = [
    ./cli
    ./stylix.nix
    ./fonts.nix

    ./git.nix
    ./code
    ./hypr/hyprland
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [];
    };
  };

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.sessionVariables = {
    # NH_FLAKE = flakeDir;
  };

  home.packages = with pkgs; [
    vesktop # discord
    neovim # tui editor
    obsidian # notes maker
    gearlever # Appimage runner
  ];

  programs.nh = {
    enable = true;
    flake = flakeDir;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  #https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
