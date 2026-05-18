{
  config,
  lib,
  pkgs,
  nix-wallpaper,
  nixgl,
  ...
}:

let
  wallpaper-pkg = nix-wallpaper.packages.${pkgs.system}.default.override {
    preset = "solarized-light";
  };
  wallpaper = "${wallpaper-pkg}/share/wallpapers/nixos-wallpaper.png";
  # swaylock must be installed via the system package manager on non-NixOS
  # (same PAM issue as with Sway — hyprlock from Nix won't have /etc/pam.d/hyprlock)
  lockCmd = "swaylock -f -i ${wallpaper}";

in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      # ── Monitor ─────────────────────────────────────────────────────────
      # Note: comma in monitor description may need escaping; adjust if Hyprland
      # misparses it (use `hyprctl monitors` to confirm the exact desc string).

      # ── Input ────────────────────────────────────────────────────────────
      input = {
        kb_layout = "de";
        follow_mouse = 1;
      };

      # ── General ──────────────────────────────────────────────────────────
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgb(268bd2)";
        "col.inactive_border" = "rgb(93a1a1)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
      };

      # ── Layout ───────────────────────────────────────────────────────────
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # ── Startup ──────────────────────────────────────────────────────────
      "exec-once" = [
        "hyprpaper"
        "hypridle"
        "nm-applet --indicator"
        "blueman-applet"
        "swaync"
      ];

      # ── Keybindings ───────────────────────────────────────────────────────
      bind = [
        # Basics
        "$mod, Return, exec, wezterm"
        "$mod SHIFT, Q, killactive"
        "$mod, D, exec, rofi -combi-modi drun -show combi -show-icons"
        "$mod SHIFT, R, exec, hyprctl reload"
        "$mod SHIFT, E, exit"

        # Lock
        "$mod SHIFT CTRL, L, exec, ${lockCmd}"

        # Screenshots (grimblast = Hyprland's grimshot equivalent)
        "$mod, P, exec, grimblast --notify copy area"
        "$mod SHIFT, P, exec, grimblast --notify copy active"

        # Brightness
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

        # Volume
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"

        # Focus (vim keys)
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        # Move (vim keys)
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"

        # Workspaces — switch
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Workspaces — move container
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Move workspace to monitor
        "$mod CTRL, H, movecurrentworkspacetomonitor, l"
        "$mod CTRL, J, movecurrentworkspacetomonitor, d"
        "$mod CTRL, K, movecurrentworkspacetomonitor, u"
        "$mod CTRL, L, movecurrentworkspacetomonitor, r"

        # Layout / window state
        "$mod, F, fullscreen"
        "$mod, E, togglesplit"
        "$mod SHIFT, space, togglefloating"
        "$mod, space, focusurgentorlast"

        # Scratchpad (special workspace)
        "$mod SHIFT, minus, movetoworkspacesilent, special:scratch"
        "$mod, minus, togglespecialworkspace, scratch"

        # Enter resize submap
        "$mod, R, submap, resize"

        # Keyboard layout cycle
        "$mod SHIFT CTRL, space, exec, hyprctl switchxkblayout all next"
      ];

      # Floating drag/resize with mouse
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      # ── Resize submap ────────────────────────────────────────────────────
      submap = resize
      binde = , H, resizeactive, -10 0
      binde = , L, resizeactive, 10 0
      binde = , K, resizeactive, 0 -10
      binde = , J, resizeactive, 0 10
      bind  = , Return, submap, reset
      bind  = , Escape, submap, reset
      submap = reset

      # ── Clamshell mode ───────────────────────────────────────────────────
      bindl = , switch:on:Lid Switch,  exec, hyprctl keyword monitor "eDP-1, disable"
      bindl = , switch:off:Lid Switch, exec, hyprctl keyword monitor "eDP-1, preferred, auto, 1"
    '';
  };

  # ── Hyprpaper ─────────────────────────────────────────────────────────
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ wallpaper ];
      wallpaper = [ ", ${wallpaper}" ];
    };
  };

  # ── Hypridle ──────────────────────────────────────────────────────────
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "pidof swaylock || ${lockCmd}";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = lockCmd;
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  # ── Packages needed at runtime ────────────────────────────────────────
  # NOTE: swaylock must be installed via the system package manager (e.g. apt)
  home.packages = with pkgs; [
    hyprpaper
    hypridle
    grimblast
    grim
    slurp
    wl-clipboard
    rofi
    swaynotificationcenter
  ];
}
