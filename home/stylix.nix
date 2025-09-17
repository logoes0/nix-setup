{
  inputs,
  pkgs,
  config,
  ...
}: let
  theme = "horizon-dark";
in {
  imports = [inputs.stylix.homeModules.stylix];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
    # image = config.lib.stylix.pixel "base0A"; # use base16Scheme

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = config.stylix.fonts.sansSerif;

      sizes = {
        terminal = 18;
        applications = 15;
        desktop = 15;
        popups = 15;
      };
    };
    cursor = {
      package = pkgs.kdePackages.breeze;
      name = "Breeze_Light";
      size = 48;
    };

    targets = {
      kitty = {
        enable = true;
        variant256Colors = true;
      };

      mako.enable = true;

      bat.enable = true;
      fzf.enable = true;
    };
  };
}
