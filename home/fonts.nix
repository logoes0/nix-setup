{pkgs, ...}: {
  fonts.fontconfig.enable = true; # enable discovery of fonts installed with home.packages

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
