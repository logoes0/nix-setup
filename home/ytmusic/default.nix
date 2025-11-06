{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    youtube-music
  ];

  xdg.configFile."YouTube Music/themes/catppuccin-mocha.css".text = ''
    /*
     * Catppuccin Mocha theme for YouTube Music
     * Source: https://github.com/catppuccin/youtubemusic
     */

    @import url("https://raw.githubusercontent.com/catppuccin/youtubemusic/main/src/mocha.css");
  '';

  home.activation.makeYoutubeMusicConfigWritable = lib.hm.dag.entryAfter ["writeBoundary"] ''
    config_path="$HOME/.config/YouTube Music/config.json"

    # Create directory if it doesn't exist
    mkdir -p "$HOME/.config/YouTube Music"

    # If it's a symlink, replace it with a writable copy
    if [ -L "$config_path" ] || [ ! -f "$config_path" ]; then
      rm -f "$config_path"
      cat > "$config_path" << 'EOF'
${builtins.toJSON {
  window-size = {
    width = 1920;
    height = 1080;
  };
  window-maximized = true;
  window-position = {
    x = 0;
    y = 0;
  };
  url = "https://music.youtube.com";
  options = {
    tray = true;
    appVisible = true;
    autoUpdates = false;
    alwaysOnTop = false;
    hideMenu = false;
    hideMenuWarned = false;
    startAtLogin = false;
    disableHardwareAcceleration = false;
    removeUpgradeButton = false;
    restartOnConfigChanges = false;
    trayClickPlayPause = false;
    autoResetAppCache = false;
    resumeOnStart = false;
    likeButtons = "force";
    proxy = "";
    startingPage = "";
    overrideUserAgent = false;
    usePodcastParticipantAsArtist = false;
    themes = [
      "catppuccin-mocha.css"
    ];
  };
  plugins = {
    notifications.enabled = false;
    video-toggle.mode = "custom";
    precise-volume = {
      globalShortcuts = { };
      enabled = true;
    };
    discord.listenAlong = true;
    bypass-age-restrictions.enabled = true;
    sponsorblock.enabled = true;
    downloader.enabled = true;
    audio-compressor.enabled = false;
    blur-nav-bar.enabled = false;
    equalizer.enabled = false;
    ambient-mode.enabled = false;
    amuse.enabled = false;
    visualizer = {
      enabled = false;
      type = "vudio";
      butterchurn = {
        preset = "martin [shadow harlequins shape code] - fata morgana";
        renderingFrequencyInMs = 500;
        blendTimeInSeconds = 2.7;
      };
      vudio = {
        effect = "lighting";
        accuracy = 128;
        lighting = {
          maxHeight = 160;
          maxSize = 12;
          lineWidth = 1;
          color = "#49f3f7";
          shadowBlur = 2;
          shadowColor = "rgba(244,244,244,.5)";
          fadeSide = true;
          prettify = false;
          horizontalAlign = "center";
          verticalAlign = "middle";
          dottify = true;
        };
      };
      wave = {
        animations = [
          {
            type = "Cubes";
            config = {
              bottom = true;
              count = 30;
              cubeHeight = 5;
              fillColor = {
                gradient = [
                  "#FAD961"
                  "#F76B1C"
                ];
              };
              lineColor = "rgba(0,0,0,0)";
              radius = 20;
            };
          }
          {
            type = "Cubes";
            config = {
              top = true;
              count = 12;
              cubeHeight = 5;
              fillColor = {
                gradient = [
                  "#FAD961"
                  "#F76B1C"
                ];
              };
              lineColor = "rgba(0,0,0,0)";
              radius = 10;
            };
          }
          {
            type = "Circles";
            config = {
              lineColor = {
                gradient = [
                  "#FAD961"
                  "#FAD961"
                  "#F76B1C"
                ];
                rotate = 90;
              };
              lineWidth = 4;
              diameter = 20;
              count = 10;
              frequencyBand = "base";
            };
          }
        ];
      };
    };
  };
  __internal__ = {
    migrations = {
      version = "3.9.0";
    };
  };
}}
EOF
      chmod u+w "$config_path"
    fi
  '';
}
