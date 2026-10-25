{ config, pkgs, ... }:
let
  hyper = "cmd-alt-ctrl-shift";
  meh = "cmd-alt-ctrl";
  sketchybar = "${pkgs.sketchybar}/bin/sketchybar";
  barHeight = 32;
  gap = 10;
in
{
  programs.aerospace = {
    enable = true;
    launchd.enable = true;
    settings = {
      config-version = 2;
      gaps.inner.horizontal = gap;
      gaps.inner.vertical = gap;
      gaps.outer.left = gap;
      gaps.outer.bottom = gap;
      gaps.outer.right = gap;
      gaps.outer.top = gap;

      # Always show pills 1-10 in the bar, even when empty
      persistent-workspaces = [
        "1"
        "2"
        "3"
        "4"
        "5"
      ];

      # Tell sketchybar which workspace is focused
      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "${sketchybar} --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
      ];

      # Rebuild the bar when AeroSpace starts (covers login ordering races)
      after-startup-command = [ "exec-and-forget ${sketchybar} --reload" ];

      mode.main.binding = {
        "${meh}-enter" =
          "exec-and-forget open -n -a ${config.programs.ghostty.package}/Applications/Ghostty.app";
        "${meh}-h" = "focus --boundaries all-monitors-outer-frame --boundaries-action stop left";
        "${meh}-j" = "focus --boundaries all-monitors-outer-frame --boundaries-action stop down";
        "${meh}-k" = "focus --boundaries all-monitors-outer-frame --boundaries-action stop up";
        "${meh}-l" = "focus --boundaries all-monitors-outer-frame --boundaries-action stop right";
        "${hyper}-h" = "move left";
        "${hyper}-j" = "move down";
        "${hyper}-k" = "move up";
        "${hyper}-l" = "move right";
        "${hyper}-minus" = "resize smart -50";
        "${hyper}-equal" = "resize smart +50";
        "${meh}-1" = "workspace 1";
        "${meh}-2" = "workspace 2";
        "${meh}-3" = "workspace 3";
        "${meh}-4" = "workspace 4";
        "${meh}-5" = "workspace 5";
        "${meh}-6" = "workspace 6";
        "${meh}-7" = "workspace 7";
        "${meh}-8" = "workspace 8";
        "${meh}-9" = "workspace 9";
        "${meh}-0" = "workspace 10";
        "${hyper}-1" = "move-node-to-workspace 1";
        "${hyper}-2" = "move-node-to-workspace 2";
        "${hyper}-3" = "move-node-to-workspace 3";
        "${hyper}-4" = "move-node-to-workspace 4";
        "${hyper}-5" = "move-node-to-workspace 5";
        "${hyper}-6" = "move-node-to-workspace 6";
        "${hyper}-7" = "move-node-to-workspace 7";
        "${hyper}-8" = "move-node-to-workspace 8";
        "${hyper}-9" = "move-node-to-workspace 9";
        "${hyper}-0" = "move-node-to-workspace 10";
      };

      mode.service.binding = {
        esc = [
          "reload-config"
          "mode main"
        ];
        r = [
          "flatten-workspace-tree"
          "mode main"
        ];
        f = [
          "layout floating tiling"
          "mode main"
        ];
        backspace = [
          "close-all-windows-but-current"
          "mode main"
        ];
        alt-shift-h = [
          "join-with left"
          "mode main"
        ];
        alt-shift-j = [
          "join-with down"
          "mode main"
        ];
        alt-shift-k = [
          "join-with up"
          "mode main"
        ];
        alt-shift-l = [
          "join-with right"
          "mode main"
        ];
      };
    };
  };
}
