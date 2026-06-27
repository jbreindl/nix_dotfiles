{ ... }:
{
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    policies = {
      ExtensionSettings = {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles = {
      default = {
        pins = {
          "Email" = {
            id = "4d246ec1-0909-4f04-b907-431fcbaadabe";
            url = "https://gmail.com";
            position = 101;
            isEssential = true;
          };
        };
        containersForce = true;
        containers = {
          Personal = {
            color = "purple";
            icon = "fingerprint";
            id = 1;
          };
          Work = {
            color = "blue";
            icon = "briefcase";
            id = 2;
          };
        };
        spacesForce = true;
        spaces = {
          # Lowest position is the default/active space on startup.
          "Personal" = {
            id = "b37dfb74-67c0-48ad-bbfb-e46b6314ce6e";
            position = 2000;
          };
          "Work" = {
            id = "665804e0-6a95-48a3-9a5d-95197d0a55f6";
            position = 1000;
          };
        };
        settings = {

          "zen.view.compact.hide-tabbar" = true;
        };

      };
    };
  };

  stylix.targets.zen-browser.profileNames = [
    "default"
  ];
  stylix.targets.zen-browser.enable = true;
}
