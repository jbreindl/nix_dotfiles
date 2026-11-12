{ lib, ... }:
{
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    autoLoad = true;
    keymaps = {
      lspBuf = {
        "gd" = "definition";
      };
    };
    servers = {
      nixd = {
        enable = true;
      };
      clangd = {
        enable = true;
        cmd = [
          "clangd"
          "--background-index"
          "--clang-tidy"
          "--header-insertion=never"
          # nixpkgs clangd doesn't know the system libstdc++ include paths
          "--query-driver=/usr/bin/*g++*,/usr/bin/*gcc*,/usr/local/cuda/bin/nvcc"
        ];
      };
      ruff.enable = true;
      ty.enable = true;
      yamlls = {
        enable = true;
        settings.yaml = {
          validate = true;
          schemaStore.enable = false;
          schemas = { };
        };
      };
      arduino_language_server = {
        enable = true;
        cmd = [
          "arduino-language-server"
          "-cli"
          "arduino-cli"
          "-cli-config"
          "~/.arduino15/arduino-cli.yaml"
          "-fqbn"
          "arduino:mbed_nano:nano33ble"
          "-clangd"
          "clangd"
        ];
        extraOptions = {
          capabilities = lib.nixvim.mkRaw ''
            vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
              textDocument = { semanticTokens = vim.NIL },
              workspace = { semanticTokens = vim.NIL },
            })
          '';
        };
      };
    };
  };
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
      formatters_by_ft = {
        python = [
          "ruff_fix"
          "ruff_format"
          "ruff_organize_imports"
        ];
      };
    };
  };
  plugins.lsp.servers.nixd.extraOptions.before_init = lib.nixvim.mkRaw ''
    function(_, config)
      local root = config.root_dir
      if not root or vim.fn.filereadable(root .. "/flake.nix") == 0 then
        return
      end
      local flake = string.format('(builtins.getFlake "%s")', root)
      -- options of the first entry in e.g. homeConfigurations, {} if absent
      local function first(attr)
        return string.format(
          '(let s = %s.%s or { }; in if s == { } then { } else s.''${builtins.head (builtins.attrNames s)}.options)',
          flake, attr)
      end
      config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
        nixd = {
          nixpkgs = { expr = string.format("import (%s.inputs.nixpkgs or <nixpkgs>) { }", flake) },
          options = {
            nixos = { expr = first("nixosConfigurations") },
            home_manager = { expr = first("homeConfigurations") },
            darwin = { expr = first("darwinConfigurations") },
          },
        },
      })
    end
  '';
}
