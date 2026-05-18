{
  config,
  lib,
  pkgs,
  nix-wallpaper,
  nixgl,
  ...
}:

let
  modifier = "Mod4";

  # Wallpaper path — adjust per machine via a host-specific override
  wallpaper-pkg = nix-wallpaper.packages.${pkgs.system}.default.override {
    preset = "solarized-light";
  };
  wallpaper = "${wallpaper-pkg}/share/wallpapers/nixos-wallpaper.png";
  lockCmd = "swaylock -f -i ${wallpaper}";
  base03 = "#002b36";
  base1 = "#93a1a1";
  base2 = "#eee8d5";
  base3 = "#fdf6e3";
  base01 = "#586e75";
  blue = "#268bd2";
  red = "#dc322f";

in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      modifier = modifier;

      terminal = "wezterm";
      menu = "rofi -combi-modi drun -show combi -show-icons";

      fonts = {
        names = [ "Lato" ];
        size = 12.0;
      };
      colors = {
        focused = {
          border = blue;
          background = blue;
          text = base3;
          indicator = blue;
          childBorder = blue;
        };
        focusedInactive = {
          border = base1;
          background = base2;
          text = base01;
          indicator = base1;
          childBorder = base1;
        };
        unfocused = {
          border = base1;
          background = base2;
          text = base01;
          indicator = base1;
          childBorder = base1;
        };
        urgent = {
          border = red;
          background = red;
          text = base3;
          indicator = red;
          childBorder = red;
        };
        placeholder = {
          border = base03;
          background = base03;
          text = base3;
          indicator = base03;
          childBorder = base03;
        };
        background = base3;
      };

      # ── Output configuration ────────────────────────────────────────────
      output = {
        "GIGA-BYTE TECHNOLOGY CO., LTD. G27Q 22102B001504" = {
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
          xkb_layout = "de";
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

      ];


      # ── Floating modifier ────────────────────────────────────────────────
      floating.modifier = modifier;

      # ── Key bindings ─────────────────────────────────────────────────────
      keybindings = lib.mkOptionDefault {
        # Basics
        "${modifier}+Return" = "exec wezterm";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec rofi -combi-modi drun -show combi -show-icons";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+e" = ''
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
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        # Move (vim keys)
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        # Workspaces — switch
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        # Workspaces — move container
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Move workspace to output
        "${modifier}+Control+h" = "move workspace to output left";
        "${modifier}+Control+j" = "move workspace to output down";
        "${modifier}+Control+k" = "move workspace to output up";
        "${modifier}+Control+l" = "move workspace to output right";

        # Lock screen
        "${modifier}+Shift+Ctrl+l" = "exec ${lockCmd}";

        # Screenshots (grimshot)
        "${modifier}+p" = "exec grimshot --notify copy area";
        "${modifier}+Shift+p" = "exec grimshot --notify copy window";

        # Layout
        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+f" = "fullscreen";

        # Floating
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";
        "${modifier}+a" = "focus parent";

        # Scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        # Resize mode
        "${modifier}+r" = "mode resize";

        # Keyboard layout cycle
        "${modifier}+Shift+Ctrl+space" = "input type:keyboard xkb_switch_layout next";
      };

      bars = [];

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

      # If you have a ./colors file, inline it here or use:
    '';
  };

  # ── Packages needed at runtime ─────────────────────────────────────────
  # NOTE: on non nixos systems, `swaylock` needs to be installed using the system package manager
  home.packages = with pkgs; [
    swayidle
    swaynotificationcenter
    sway-contrib.grimshot
    grim
    slurp
    wl-clipboard
    rofi
  ];

  # ── Session variables ──────────────────────────────────────────────────
}
