{
  config,
  lib,
  pkgs,
  ...
}:

let
  modifier = "Mod4";
  meh = "Mod4+Mod1+Control";
  hyper = "Mod4+Mod1+Control+Shift";

  # Wallpaper path — adjust per machine via a host-specific override
  # wallpaper-pkg = nix-wallpaper.packages.${pkgs.system}.default.override {
  #   preset = "solarized-light";
  # };
  wallpaper = "${config.wallpaper.image}";
  lockCmd = "swaylock -f -i ${wallpaper}";

in
{
  imports = [
    ../waybar/waybar.nix
    ../waybar/sway.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    # The wallpaper lives in $HOME, which the Nix build sandbox can't see, so
    # `sway -C` fails on the `bg` lines. Disable the build-time config check.
    checkConfig = false;

    config = {
      modifier = modifier;

      menu = "rofi -combi-modi drun -show combi -show-icons";

      # ── Output configuration ────────────────────────────────────────────
      output = {
        "GIGA-BYTE TECHNOLOGY CO., LTD. G27Q 22102B001504" = {
          mode = "2560x1440@144Hz";
          scale = "1";
          scale_filter = "smart";
          position = "0 0";
          bg = "${wallpaper} fill";
        };
        "AOC Q32G2WG3 PSAN9JA000432" = {
          mode = "2560x1440@144Hz";
          scale = "1";
          scale_filter = "smart";
          position = "0 0";
          bg = "${wallpaper} fill";
        };
        # Fallback wallpaper for all other outputs
        "*" = {
          bg = "${wallpaper} fill";
        };
      };

      # ── Input configuration ─────────────────────────────────────────────
      input = {
        "*" = {
          xkb_layout = "us,de";
          xkb_variant = "mac,";
        };
      };

      # ── Gaps ────────────────────────────────────────────────────────────
      gaps = {
        inner = 5;
        outer = 5;
      };

      # ── Borders ─────────────────────────────────────────────────────────
      # mysterious claude code block
      window = {
        commands = [
          {
            command = "border pixel 2";
            criteria = {
              app_id = ".*";
            };
          }
        ];
      };

      # ── Startup programs ────────────────────────────────────────────────
      startup = [
        {
          command = ''
            swayidle -w \
              timeout 300 '${lockCmd}' \
              timeout 600 'swaymsg "output * power off"' \
              resume 'swaymsg "output * power on"' \
              before-sleep '${lockCmd}'
          '';
        }

        { command = "nm-applet --indicator "; }
        { command = "blueman-applet"; }
        { command = "swaync"; }
        { command = "waybar"; }

      ];

      # ── Floating modifier ────────────────────────────────────────────────
      floating.modifier = modifier;

      # ── Key bindings ─────────────────────────────────────────────────────
      keybindings = {
        # Basics
        "${meh}+Return" = "exec env GTK_IM_MODULE=simple ghostty";
        "${meh}+q" = "kill";
        "${meh}+d" = "exec rofi -combi-modi drun -show combi -show-icons";
        "${meh}+space" = "exec rofi -combi-modi drun -show combi -show-icons";
        "${hyper}+r" = "reload";
        "${hyper}+e" = ''
          exec swaynag -t warning \
            -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' \
            -B 'Yes, exit sway' 'swaymsg exit'
        '';

        # Brightness
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";

        # # Volume (drop $refresh_i3status — waybar auto-updates)
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";

        # Focus (vim keys)
        "${meh}+h" = "focus left";
        "${meh}+j" = "focus down";
        "${meh}+k" = "focus up";
        "${meh}+l" = "focus right";

        # Move (vim keys)
        "${hyper}+h" = "move left";
        "${hyper}+j" = "move down";
        "${hyper}+k" = "move up";
        "${hyper}+l" = "move right";

        # Workspaces — switch
        "${meh}+1" = "workspace number 1";
        "${meh}+2" = "workspace number 2";
        "${meh}+3" = "workspace number 3";
        "${meh}+4" = "workspace number 4";
        "${meh}+5" = "workspace number 5";
        "${meh}+6" = "workspace number 6";
        "${meh}+7" = "workspace number 7";
        "${meh}+8" = "workspace number 8";
        "${meh}+9" = "workspace number 9";
        "${meh}+0" = "workspace number 10";

        # Workspaces — move container
        "${hyper}+1" = "move container to workspace number 1";
        "${hyper}+2" = "move container to workspace number 2";
        "${hyper}+3" = "move container to workspace number 3";
        "${hyper}+4" = "move container to workspace number 4";
        "${hyper}+5" = "move container to workspace number 5";
        "${hyper}+6" = "move container to workspace number 6";
        "${hyper}+7" = "move container to workspace number 7";
        "${hyper}+8" = "move container to workspace number 8";
        "${hyper}+9" = "move container to workspace number 9";
        "${hyper}+0" = "move container to workspace number 10";

        # Move workspace to output
        "${modifier}+Control+h" = "move workspace to output left";
        "${modifier}+Control+j" = "move workspace to output down";
        "${modifier}+Control+k" = "move workspace to output up";
        "${modifier}+Control+l" = "move workspace to output right";

        # Lock screen
        "${modifier}+Shift+Ctrl+l" = "exec ${lockCmd}";

        # Screenshots (grimshot)
        "${meh}+p" = "exec grimshot --notify copy area";
        "${hyper}+p" = "exec grimshot --notify copy window";

        # Layout
        "${meh}+b" = "splith";
        "${meh}+v" = "splitv";
        "${meh}+s" = "layout stacking";
        "${meh}+w" = "layout tabbed";
        "${meh}+e" = "layout toggle split";
        "${meh}+f" = "fullscreen";

        # Floating
        "${hyper}+space" = "floating toggle";
        "${meh}+t" = "focus mode_toggle";
        "${meh}+a" = "focus parent";

        # Scratchpad
        "${hyper}+minus" = "move scratchpad";
        "${meh}+minus" = "scratchpad show";

        # Resize mode
        "${meh}+r" = "mode resize";

        # Keyboard layout cycle
        "${modifier}+Shift+Ctrl+space" = "input type:keyboard xkb_switch_layout next";
      };

      bars = [ ];

      # ── Resize mode ──────────────────────────────────────────────────────
      modes = {
        resize = {
          # Vim keys
          h = "resize shrink width 10px";
          j = "resize grow height 10px";
          k = "resize shrink height 10px";
          l = "resize grow width 10px";
          # Exit
          Return = "mode default";
          Escape = "mode default";
        };
      };

    };

    # ── Raw config for things the module doesn't expose ───────────────────
    extraConfig = ''
      # Clamshell mode (lid switch)
      set $laptop eDP-1
      bindswitch --reload --locked lid:on output $laptop disable
      bindswitch --reload --locked lid:off output $laptop enable

      # Enables inhibit_idle when playing audio
      exec sway-audio-idle-inhibit  
    '';
  };

  # ── Packages needed at runtime ─────────────────────────────────────────
  # NOTE: on non nixos systems, `swaylock` needs to be installed using the system package manager
  home.packages = with pkgs; [
    swayidle
    sway-contrib.grimshot
    grim
    slurp
    wl-clipboard
    rofi
  ];
  services.swaync.enable = true;

}
