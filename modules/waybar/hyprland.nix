{ ... }:

{
  programs.waybar.settings.mainBar = {
    modules-center = [
      "hyprland/workspaces"
      "hyprland/submap"
    ];

    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = false;
      warp-on-scroll = false;
      format = "{id}";
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
