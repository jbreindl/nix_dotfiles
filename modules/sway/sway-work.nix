{ ... }:

{
  imports = [
    ./sway.nix
  ];
  wayland.windowManager.sway = {
    config = {
      assigns = {
        "2" = [
          { app_id = "teams-for-linux"; }
          { instance = "thunderbird"; }
        ];
      };
      output = {
        DP-7 = {
          position = "0 0";
          mode = "2560x1440";
        };
        DP-8 = {
          mode = "2560x1440";
        };
      };

      startup = [
        { command = "teams-for-linux"; }
        { command = "thunderbird"; }
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
