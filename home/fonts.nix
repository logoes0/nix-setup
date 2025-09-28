{pkgs, ...}: {
  fonts.fontconfig.enable = true; # enable discovery of fonts installed with home.packages

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
    nerd-fonts.mononoki
    nerd-fonts.dejavu-sans-mono
  ];
}
