{ config, ... }:

let
  inherit (config.lib.stylix) colors;
  inherit (config.stylix) fonts;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 8;
        margin-left = 8;
        margin-right = 8;

        modules-left = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "battery"
          "idle_inhibitor"
          "custom/notification"
          "tray"
        ];

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        "tray" = {
          spacing = 10;
          show-passive-items = true;
        };

        "clock" = {
          format = "{:%a %d %b - %H:%M}";
        };

        "cpu" = {
          format = "{usage}% ";
          tooltip = false;
        };

        "memory" = {
          format = "{}% ";
        };

        "network" = {
          format-wifi = "{essid} ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        "pulseaudio" = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "{icon} {format_source}";
          format-source = "{volume}% ";
          format-source-muted = " ";
          format-icons = {
            headphone = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        "battery" = {
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "custom/notification" = {
          tooltip = true;
          format = "<span size='16pt'>{icon}</span>";
          format-icons = {
            notification = "󱅫 ";
            none = "󰂜 ";
            dnd-notification = "󰂠 ";
            dnd-none = "󰪓 ";
            inhibited-notification = "󰂛 ";
            inhibited-none = "󰪑 ";
            dnd-inhibited-notification = "󰂛 ";
            dnd-inhibited-none = "󰪑 ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };

    style = ''
      /* Colors sourced from the Stylix base16 scheme (see modules/stylix.nix) */
      * {
          border: none;
          border-radius: 10px;
          font-size: 16px;
          min-height: 0;
      }

      window#waybar {
          background: transparent;
          color: ${colors.withHashtag.base05};
      }

      .modules-left,
      .modules-center,
      .modules-right {
          background: ${colors.withHashtag.base01};
          border-radius: 10px;
          padding: 4px 8px 4px 8px;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: ${colors.withHashtag.base05};
      }

      #workspaces button.hover {
          box-shadow: inherit;
          text-shadow: inherit;
          border-bottom: 3px solid ${colors.withHashtag.base0C};
      }

      #workspaces button.active,
      #workspaces button.focused {
          background: ${colors.withHashtag.base03};
          color: ${colors.withHashtag.base0E};
      }

      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #tray {
          padding: 0 10px;
          margin: 0 0px;
          color: ${colors.withHashtag.base05};
      }

      #battery.charging {
          color: ${colors.withHashtag.base0B};
      }

      #battery.warning:not(.charging) {
          color: ${colors.withHashtag.base08};
      }

      #network.disconnected {
          color: ${colors.withHashtag.base08};
      }

      #pulseaudio.muted {
          color: ${colors.withHashtag.base08};
      }
    '';
  };
}
