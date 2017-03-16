{ lib }:

with lib;
{
  options = {
    format = mkOption {
      type = types.nullOr types.str;
      default = null;
    };

    format_up = mkOption {
      type = types.nullOr types.str;
      default = null;
    };

    format_down = mkOption {
      type = types.nullOr types.str;
      default = null;
    };

    path = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
  };
}
