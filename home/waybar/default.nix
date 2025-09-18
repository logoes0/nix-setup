{pkgs, ...}: let
in {
  home.packages = with pkgs; [
    pulseaudio # gives pactl command
    pavucontrol
    # networkmanagerapplet # nm-connection-editor
  ];

  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        reload_style_on_change = true;

        modules-left = [
          "hyprland/workspaces"
          "wlr/taskbar"
          "hyprland/window"
        ];
        modules-center = [
        ];
        modules-right = [
          "tray"
          "group/util"
          "group/pfstats"
          "group/hwstats"
          "clock"
        ];

        "wlr/taskbar" = {
          format = "{icon}";
          tooltip-format = "{title}";
          icon-size = 20;
          on-click = "activate";
          on-click-middle = "close";
          sort-by-app-id = true;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            urgent = "";
            active = "";
            empty = "";
          };
          persistent-workspaces = {
            "*" = [1 2 3 4];
          };
        };

        "hyprland/window" = {
          format = " {class}";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = false;
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };

        clock = {
          tooltip-format = "<span><tt><big>{calendar}</big></tt></span>";
          format = "{:%H:%M}  ";
          format-alt = "{:%d/%m/%Y, %a}  ";
          calendar = {
            mode-mon-col = 3;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
            on-click-right = "shift_reset";
            on-click = "mode";
          };
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
          interval = 10;
        };

        memory = {
          format = "{percentage}% ";
          interval = 10;
        };

        battery = {
          states = {
            # good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };

        network = {
          interval = 10;
          # format = "{bandwidthUpBytes}  {bandwidthDownBytes}   ";
          format-ethernet = "󰌗";
          format-wifi = "{icon}";
          format-disconnected = "";
          tooltip-format = "{ifname}";
          tooltip-format-wifi = "{essid}";
          format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
          on-click = "kitty nmtui";
        };

        bluetooth = {
          format-no-controller = "";
        };

        pulseaudio = {
          # scroll-step = 1; # %, can be a float
          format = "{volume}% {icon}  {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "󰖁  {format_source}";
          format-source = "󰍬";
          format-source-muted = "󰍭";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = ["󰕿" "󰖀" "󰕾"];
          };
          scroll-step = 5.0;
          on-click = "pavucontrol";
          on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click-middle = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        };

        privacy = {
          icon-spacing = 4;
          icon-size = 18;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-out";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 24;
            }
          ];
        };

        "custom/hyprpicker" = {
          on-click = "hyprpicker -an -f hex";
          exec-on-event = true;
          format = "";
          tooltip = false;
        };

        "custom/hyprsunset" = {
          on-scroll-up = "hyprctl hyprsunset temperature +400";
          on-scroll-down = "hyprctl hyprsunset temperature -400";
          format = "";
          tooltip = false;
        };

        "custom/clipse" = {
          on-click = "kitty --class clipse 'clipse'";
          exec-on-event = true;
          tooltip = false;
          format = "";
        };

        "group/pfstats" = {
          orientation = "horizontal";
          modules = [
            "memory"
            # "disk"
            "cpu"
          ];
        };

        "group/hwstats" = {
          orientation = "horizontal";
          modules = [
            "privacy"
            "idle_inhibitor"
            "pulseaudio"
            "bluetooth"
            "network"
            "battery"
          ];
        };

        "group/util" = {
          orientation = "horizontal";
          modules = [
            "custom/hyprpicker"
            "custom/hyprsunset"
            "custom/clipse"
          ];
        };
      };
    };
  };
}
