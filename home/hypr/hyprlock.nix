# In your home.nix or a dedicated hyprlock.nix file

{
  # For Home Manager, the path is programs.hyprlock
  # For system-wide NixOS config, it might be services.hyprlock
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        hide_cursor = false;
      };

      # Note: background, input-field, and label are lists
      background = [{
        monitor = "";
        color = "rgba(20, 20, 20, 1.0)"; # Simple solid background
      }];

      "input-field" = [{
        monitor = "";
        size = "250, 50";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;

        inner_color = "rgb(20, 20, 20)";
        outer_color = "rgb(200, 200, 200)";
        font_color = "rgb(200, 200, 200)";

        fade_on_empty = false;
        placeholder_text = "<i>Password...</i>";
        halign = "center";
        valign = "center";
        position = "0, -20";
        rounding = 15;
      }];

      label = [{
        monitor = "";
        text = "$TIME";
        color = "rgb(200, 200, 200)";
        font_size = 90;
        font_family = "Monospace";
        position = "0, 150";
        halign = "center";
        valign = "center";
      }];
    };
  };
}

# {
#   programs.hyprlock = {
#     enable = true;
#     settings = {
#       "$font" = "Monospace";
#
#       general = {
#         hide_cursor = false;
#       };
#
#       animations = {
#         enabled = true;
#         bezier = "linear, 1, 1, 0, 0";
#         animation = [
#           "fadeIn, 1, 5, linear"
#           "fadeOut, 1, 5, linear"
#           "inputFieldDots, 1, 2, linear"
#         ];
#       };
#
#       background = [
#         {
#           monitor = "";
#           path = "/home/logoes0/wallhaven-831wv2.jpg";
#           blur_passes = 3;
#         }
#       ];
#
#       input-field = [
#         {
#           monitor = "";
#           size = "20%, 5%";
#           outline_thickness = 3;
#           inner_color = "rgba(0, 0, 0, 0.0)"; # no fill
#
#           outer_color = "rgba(33ccffee) rgba(00ff99ee) 45deg";
#           check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
#           fail_color = "rgba(ff6633ee) rgba(ff0066ee) 40deg";
#
#           font_color = "rgb(143, 143, 143)";
#           fade_on_empty = false;
#           rounding = 15;
#
#           font_family = "$font";
#           placeholder_text = "Input password...";
#           fail_text = "$PAMFAIL";
#           dots_spacing = 0.3;
#
#           position = "0, -20";
#           halign = "center";
#           valign = "center";
#         }
#       ];
#
#       label = [
#         # TIME
#         {
#           monitor = "";
#           text = "$TIME";
#           font_size = 90;
#           font_family = "$font";
#
#           position = "-30, 0";
#           halign = "right";
#           valign = "top";
#         }
#
#         # DATE
#         {
#           monitor = "";
#           text = ''cmd[update:60000] date +"%A, %d %B %Y"''; # update every 60 seconds
#           font_size = 25;
#           font_family = "$font";
#
#           position = "-30, -150";
#           halign = "right";
#           valign = "top";
#         }
#       ];
#     };
#   };
# }
