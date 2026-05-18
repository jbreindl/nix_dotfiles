{ ... }:

{
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
    };


  };
}
