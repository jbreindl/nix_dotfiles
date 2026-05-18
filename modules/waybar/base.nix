{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 8;
        margin-left = 8;
        margin-right = 8;

        modules-center = [ "clock" ];

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
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
          format = "{usage}% ";
          tooltip = false;
        };

        "memory" = {
          format = "{}% ";
        };

        "network" = {
          format-wifi = "{essid} ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        "pulseaudio" = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        "battery" = {
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-icons = [ "" "" "" "" "" ];
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
      * {
          border: none;
          border-radius: 10px;
          font-family: "JetBrains Mono", "Symbols Nerd Font Mono";
          font-size: 16px;
          min-height: 0;
      }

      window#waybar {
          background: transparent;
          color: #586e75;
      }

      .modules-left,
      .modules-center,
      .modules-right {
          background: #fdf6e3;
          border-radius: 10px;
          padding: 0 8px 0 0px;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: #586e75;
          border-bottom: 3px solid transparent;
      }

      #workspaces button.active {
          border-bottom: 10px solid black;
      }

      #workspaces button.hover {
          box-shadow: inherit;
          text-shadow: inherit;
          border-bottom: 3px solid #2aa198;
      }

      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #tray {
          padding: 0 10px;
          margin: 0 0px;
      }

      #battery.charging {
          color: #859900;
      }

      #battery.warning:not(.charging) {
          color: #dc322f;
      }

      #network.disconnected {
          color: #dc322f;
      }

      #pulseaudio.muted {
          color: #dc322f;
      }
    '';
  };
}
