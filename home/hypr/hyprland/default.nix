{
  pkgs,
  lib,
  config,
  ...
}: let
in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    systemd.variables = ["--all"];
    settings = {
      "$mod" = "SUPER";

      "$terminal" = "kitty";
      "$menu" = "rofi";

      env = [
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "QT_QPA_PLATFORM, wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_QPA_PLATFORMTHEME, qt6ct"

        "XCURSOR_THEME, Breeze_Light"
        "XCURSOR_SIZE, 48"
        "HYPRCURSOR_SIZE, 48"
      ];

      exec-once = [
        "clipse -listen"
        "mako"
        "waybar"
        "hyprpaper"
        "hypridle"
        "hyprsunset"
      ];
    };
  };

  imports = [
    ./general.nix
    ./binds.nix
    ./windowrules.nix

    ../../kitty.nix
    ../../mako.nix
    ../../waybar
    # ../../anyrun
    ../../rofi
    ../hypridle.nix
    ../hyprsunset.nix
    ../hyprlock.nix
  ];

  home.packages = with pkgs; [
    clipse # clipboard manager
    wl-clipboard

    hyprpicker # color-picker
    grimblast # screenshot
    hyprpaper # wallpaper
    # wlogout

    # Qt theming
    # kdePackages.qt6ct
    # qt6ct-kde
    kdePackages.qtstyleplugin-kvantum

    # GTK theming
    nwg-look
  ];
}
