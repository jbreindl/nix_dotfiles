{ lib, ... }:
{
  options.my.aiBackend = lib.mkOption {
    type = lib.types.enum [
      "claude"
      "local"
    ];
    default = "claude";
  };
}
