{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = false;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 3;
          inner_color = "rgba(0, 0, 0, 0.0)";
          outer_color = "rgba(51, 204, 255, 0.93)";
          check_color = "rgba(0, 255, 153, 0.93)";
          fail_color = "rgba(255, 102, 51, 0.93)";
          font_color = "rgb(143, 143, 143)";
          fade_on_empty = false;
          rounding = 15;
          placeholder_text = "Input password...";
          dots_spacing = 0.3;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # TIME
        {
          monitor = "";
          text = "$TIME";
          font_size = 90;
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        # DATE
        {
          monitor = "";
          text = ''cmd[update:60000] date +"%A, %d %B %Y"'';
          font_size = 25;
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];
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
#           path = "screenshot";
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
