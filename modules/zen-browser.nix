{ ... }:
{
  programs.zen-browser.enable = true;
  programs.zen-browser.profiles = {
    default = {
      pins = {
        "Email" = {
          id = "4d246ec1-0909-4f04-b907-431fcbaadabe";
          url = "https://gmail.com";
          position = 101;
          isEssential = true;
        };
      };
      spaces = {
        "Test" = {
          id = "space:test";
          position = 1000;
        };
      };
      settings = {

        "zen.view.compact.hide-tabbar" = true;
      };

    };
  };

  stylix.targets.zen-browser.profileNames = [
    "default"
  ];
  stylix.targets.zen-browser.enable = true;
}
