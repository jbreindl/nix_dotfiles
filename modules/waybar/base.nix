{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 8;
        margin-left = 8;
        margin-right = 8;

        modules-left = [ "clock" ];

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
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
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
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
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "custom/notification" = {
          tooltip = true;
          format = "<span size='16pt'>{icon}</span>";
          format-icons = {
            notification = "󱅫";
            none = "󰂜";
            dnd-notification = "󰂠";
            dnd-none = "󰪓";
            inhibited-notification = "󰂛";
            inhibited-none = "󰪑";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰪑";
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
      /* Catppuccin Latte */
      * {
          border: none;
          border-radius: 10px;
          font-family: "Fira Code Mono", "Symbols Nerd Font Mono";
          font-size: 16px;
          min-height: 0;
      }

      window#waybar {
          background: transparent;
          color: #4c4f69;
      }

      .modules-left,
      .modules-center,
      .modules-right {
          background: #ccd0da;
          border-radius: 10px;
          padding: 4px 8px 4px 8px;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: #4c4f69;
      }

      #workspaces button.hover {
          box-shadow: inherit;
          text-shadow: inherit;
          border-bottom: 3px solid #179299;
      }

      #workspaces button.active,
      #workspaces button.focused {
          background: #acb0be;
          color: #8839ef;
      }

      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #tray {
          padding: 0 10px;
          margin: 0 0px;
          color: #4c4f69;
      }

      #battery.charging {
          color: #40a02b;
      }

      #battery.warning:not(.charging) {
          color: #d20f39;
      }

      #network.disconnected {
          color: #d20f39;
      }

      #pulseaudio.muted {
          color: #d20f39;
      }
    '';
  };
}
