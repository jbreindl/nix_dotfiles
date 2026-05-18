{ ... }:

{
  programs.waybar.settings.mainBar = {
    modules-left = [
      "sway/workspaces"
      "sway/mode"
    ];
    modules-right = [
      "pulseaudio"
      "cpu"
      "memory"
      "battery"
      "idle_inhibitor"
      "sway/language"
      "custom/notification"
      "tray"
    ];

    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = false;
      warp-on-scroll = false;
      format = "{value}: {icon}";
      format-icons = {
        urgent = "";
        focused = "";
        default = "";
      };
    };

    "sway/language" = {
      format = "{shortDescription}";
    };

    "sway/mode" = {
      format = "<span style=\"italic\">{}</span>";
    };
  };
}
