{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # Command to lock

        # THIS IS THE KEY FIX: Lock, then wait 1 second before sleeping
        before_sleep_cmd = "pidof hyprlock || hyprlock && sleep 1";

        after_sleep_cmd = "hyprctl dispatch dpms on";  # Wake up display
      };

      listener = [
        # Lock the screen after 5 minutes
        {
          timeout = 300; # 5min
          on-timeout = "pidof hyprlock || hyprlock"; # Use the lock_cmd directly
        }
        # Turn off the display after 5.5 minutes
        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # Screen off
          on-resume = "hyprctl dispatch dpms on";  # Screen on
        }
        # Suspend the system after 7 minutes
        {
          timeout = 420; # 7min
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
