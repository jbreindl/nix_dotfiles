{ ... }:

{
  programs.waybar.settings.mainBar = {
    modules-left = [
      "hyprland/workspaces"
      "hyprland/submap"
    ];
    modules-right = [
      "pulseaudio"
      "cpu"
      "memory"
      "battery"
      "idle_inhibitor"
      "hyprland/language"
      "custom/notification"
      "tray"
    ];

    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = false;
      warp-on-scroll = false;
      format = "{id}: {icon}";
      format-icons = {
        urgent = "";
        active = "";
        default = "";
      };
    };

    "hyprland/language" = {
      format = "{short}";
    };

    "hyprland/submap" = {
      format = "<span style=\"italic\">{}</span>";
      tooltip = false;
    };
  };
}
