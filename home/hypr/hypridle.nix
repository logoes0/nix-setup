{
  services.hypridle = {
    enable = true;
    settings = {
      # The NixOS module groups top-level directives into the 'general' section.
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "pidof hyprlock || hyprlock && sleep 1";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      # Each listener block from the .conf file becomes an attribute set in this list.
      listener = [
        {
          timeout = 10; # 5 minutes to lock
          on-timeout = "pidof hyprlock || hyprlock";
        }
        {
          timeout = 20; # 5.5 minutes to screen off
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 30; # 7 minutes to suspend
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}

# {
#   services.hypridle = {
#     enable = true;
#     settings = {
#       general = {
#         lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances
#         before_sleep_cmd = "loginctl lock-session"; # lock before suspend
#         after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display
#         # ignore_dbus_inhibit = false;
#       };
#
#       listener = [
#         {
#           timeout = 300; # 5min
#           on-timeout = "loginctl lock-session"; # lock screen when timeout passed
#         }
#         {
#           timeout = 330; # 5.5min
#           on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout passed
#           on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired
#         }
#         {
#           timeout = 420; # 7min
#           on-timeout = "systemctl suspend"; # suspend pc
#         }
#       ];
#     };
#   };
# }
