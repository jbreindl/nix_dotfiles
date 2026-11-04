{ pkgs, ... }:
let
  gap = 10;
in
{
  xdg.dataFile."kwin/scripts/krohnkite".source =
    "${pkgs.kdePackages.krohnkite}/share/kwin/scripts/krohnkite";

  # plasma-manager scripts call `qdbus`; Ubuntu only ships it under qt6/bin
  home.packages = [
    (pkgs.writeShellScriptBin "qdbus" ''exec /usr/lib/qt6/bin/qdbus "$@"'')
  ];

  programs.plasma = {
    enable = true;

    kwin.virtualDesktops = {
      number = 5;
      rows = 1;
    };

    configFile = {
      kwinrc = {
        Plugins = {
          krohnkiteEnabled = true;
          poloniumEnabled = false;
          slideEnabled = false;
          diminactiveEnabled = true;
        };
        Effect-diminactive.Strength = 10;
        Windows.FocusPolicy = "ClickToFocus";

        Script-krohnkite = {
          binaryTreeLayoutOrder = 1;
          columnsLayoutOrder = 2;
          monocleLayoutOrder = 3;
          tileLayoutOrder = 0;
          threeColumnLayoutOrder = 0;
          spiralLayoutOrder = 0;
          quarterLayoutOrder = 0;
          stackedLayoutOrder = 0;
          spreadLayoutOrder = 0;
          floatingLayoutOrder = 0;
          stairLayoutOrder = 0;
          cascadeLayoutOrder = 0;

          layoutPerDesktop = true;
          monocleMaximize = false;
          screenGapBetween = gap;
          screenGapBottom = gap;
          screenGapLeft = gap;
          screenGapRight = gap;
          screenGapTop = gap;
        };
      };
      kdeglobals.KDE.AnimationDurationFactor = 0;
    };

    panels = [
      {
        location = "top";
        widgets = [
          {
            pager.general = {
              showWindowOutlines = false;
              displayedText = "desktopNumber";
            };
          }
          "org.kde.plasma.panelspacer"
          {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "24h";
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.kickoff"
        ];
      }
    ];
  };
}
