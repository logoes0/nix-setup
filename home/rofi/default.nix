{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = [pkgs.rofi];
  xdg.configFile."rofi/config.rasi".source = ./config.rasi;
}
