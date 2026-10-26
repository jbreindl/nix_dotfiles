{ ... }:

{
  programs.waybar.settings.mainBar = {
    modules-center = [
      "sway/workspaces"
      "sway/mode"
    ];
    modules-right = [
      "sway/language"
    ];

    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = false;
      warp-on-scroll = false;
      format = "{value}";
    };

    "sway/language" = {
      format = "{short} {variant}";
      tooltip-format = "{long}";
      on-click = "swaymsg input type:keyboard xkb_switch_layout next";
    };

    "sway/mode" = {
      format = "<span style=\"italic\">{}</span>";
    };
  };
}
