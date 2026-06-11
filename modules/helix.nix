{ ... }:
{
  programs.helix.enable = true;
  programs.helix.defaultEditor = true;
  programs.helix.settings = {
    theme = "catppuccin_latte_transparent";
    editor = {
      true-color = true;
      line-number = "relative";
      indent-guides = {
        render = true;
        character = "|";
      };
    };
  };
  programs.helix.themes = {
    solarized_light_transparent = {
      "inherits" = "solarized_light";
      "ui.background" = { };
    };
    catppuccin_latte_transparent = {

      "inherits" = "catppuccin_latte";
      "ui.background" = { };
    };

    nord_light_transparent = {
      "inherits" = "nord_light";
      "ui.background" = { };

    };
  };
  programs.helix.languages = {
    language = [
      {
        name = "nix";
        language-servers = [
          "nil"
          "nixd"
        ];
        auto-format = true;
        formatter = {
          command = "nixfmt";
        };
      }
      {
        name = "python";
        language-servers = [
          "ty"
          "ruff"
        ];
        auto-format = true;
        formatter = {
          command = "bash";
          args = [
            "-c"
            "uvx ruff check --fix --select I - | uvx ruff format -"
          ];
        };
      }
      {
        name = "rust";
        language-servers = [ "rust-analyzer" ];
        auto-format = true;
      }
    ];
    language-server.ruff = {
      command = "uvx";
      args = [
        "ruff"
        "server"
      ];
    };
    language-server.ty = {
      command = "uvx";
      args = [
        "ty"
        "server"
      ];
    };
    language-server.rust-analyzer = {
      command = "rust-analyzer";
      config = {
        check.command = "clippy";
        procMacro.enable = true;
      };
    };

  };
}
