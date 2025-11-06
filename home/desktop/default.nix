{
  lib,
  inputs,
  host,
  pkgs,
  hostVariables, # <-- still present for browser/terminal etc
  ...
}:
let
  inherit (hostVariables)
    browser
    terminal
    ;
in
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;
    immutableByDefault = true;
    krunner.activateWhenTypingOnDesktop = false;
    workspace = {
      clickItemTo = "select"; # select, open
      lookAndFeel = "Catppuccin-Mocha-Mauve"; # Global Theme
      colorScheme = "CatppuccinMochaMauve";
      theme = "default"; # Plasma Style
      cursor = {
        size = 24;
        theme = "Bibata-Modern-Classic";
      };
      # wallpaper removed per request
    };
    kwin = {
      effects = {
        blur.enable = false;
        cube.enable = false;
        desktopSwitching.animation = "off";
        dimAdminMode.enable = false;
        dimInactive.enable = false;
        fallApart.enable = false;
        fps.enable = false;
        minimization.animation = "off";
        shakeCursor.enable = false;
        slideBack.enable = false;
        snapHelper.enable = false;
        translucency.enable = false;
        windowOpenClose.animation = "off";
        wobblyWindows.enable = false;
      };

      # Ensure only a single virtual desktop exists
      virtualDesktops = {
        number = 1;
        rows = 1;
      };
    };
    input = {
      keyboard = {
        numlockOnStartup = "on";
        repeatDelay = 275;
        repeatRate = 35;
      };
      mice = [
        {
          acceleration = 1.0;
          accelerationProfile = "none";
          # Use simple defaults instead of probing at build time
          name = "auto";
          vendorId = "0";
          productId = "0";
        }
      ];
    };

    panels = [
      {
        screen = "all";
        height = 36;
        widgets = [
          # removed "org.kde.plasma.pager" to hide virtual desktop UI
          "org.kde.plasma.panelspacer"

          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake";
              };
            };
          }

          {
            iconTasks.launchers = [
              "applications:firefox.desktop"
              "applications:org.kde.dolphin.desktop"
            ];
          }

          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    shortcuts = { };
    hotkeys.commands = {
      "launch-${terminal}" = {
        name = "Launch ${terminal}";
        key = "Meta+T";
        command = "${terminal}";
      };
      "launch-firefox" = {
        name = "Launch Firefox";
        key = "Meta+F";
        command = "firefox";
      };
    };
    powerdevil = {
      AC = {
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "sleep";
        powerProfile = "performance";
        whenLaptopLidClosed = "sleep";
        autoSuspend = {
          action = "nothing";
        };
        turnOffDisplay = {
          idleTimeout = "never";
        };
      };
      battery = {
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "showLogoutScreen";
        powerProfile = "balanced";
        whenLaptopLidClosed = "sleep";
        autoSuspend = {
          action = "sleep";
          idleTimeout = 600;
        };
        turnOffDisplay = {
          idleTimeout = 360;
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 120;
        };
      };
      batteryLevels = {
        criticalLevel = 5;
        criticalAction = "shutDown";
      };
    };
    kscreenlocker = {
      autoLock = true;
      timeout = 5;
      passwordRequired = true;
      passwordRequiredDelay = 0;
      lockOnResume = true;
    };
    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore = {
        restoreOpenApplicationsOnLogin = "startWithEmptySession";
      };
    };
    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
    };
  };

}
