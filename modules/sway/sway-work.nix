{ ... }:

{
  imports = [
    ./base.nix
  ];
  wayland.windowManager.sway = {
    config = {
      assigns = {
        "2" = [
          { app_id = "teams-for-linux"; }
          { instance = "outlook-for-linux"; }
        ];
      };

      startup = [
        { command = "teams-for-linux"; }
        { command = "outlook-for-linux"; }
      ];
      input = {
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "us";
          xkb_variant = "colemak_dh_iso";
        };
      };

    };
  };
}
