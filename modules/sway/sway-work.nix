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

      startup = [
        { command = "teams-for-linux"; }
        { command = "outlook-for-linux"; }
        { command = "thunderbird"; }
      ];

    };
  };
}
