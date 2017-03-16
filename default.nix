{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.tools.i3status-configurator;

  mkOptions = options: concatStringsSep "\n" (mapAttrsToList (option: config: ''
    ${option} {
      ${optionalString (config.format != null) "format = \"${config.format}\""}
      ${optionalString (config.format_up != null) "format_up = \"${config.format_up}\""}
      ${optionalString (config.format_down != null) "format_down = \"${config.format_down}\""}
      ${optionalString (config.path != null) "path = \"${config.path}\""}
    }
  '') options);

  mkOrder = order: concatStringsSep "\n" (imap (key: element: ''
    order += "${toString element}"
  '') order);

  mkConfig = cfg: ''
    general {
      colors = ${if cfg.colors == true then "true" else "false"}
      interval = "${toString cfg.interval}"
    }

    ${mkOrder cfg.order}

    ${mkOptions cfg.config}
  '';

in
{
  options = {
    tools.i3status-configurator = {
      enable = mkEnableOption "i3 status";

      colors = mkOption {
        default = true;
        type = types.bool;
      };

      interval = mkOption {
        default = 5;
        type = types.int;
      };

      order = mkOption {
        type = types.listOf types.string;
        default = [
          "load" "cpu_temperature 0"
          "wireless _first_" "ethernet _first_"
          "battery all" "tztime local"
        ];
      };

      config = mkOption {
        type = types.attrsOf (types.submodule (import ./config-options.nix {
          inherit lib;
        }));
        default = import ./config-default.nix;
      };

      configFile = mkOption {
        type = types.lines;
        default = mkConfig cfg;
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.services.xserver.windowManager.i3.enable;
      message = "You need to enable i3 first.";
    }];

    environment.etc."i3status.conf".text = cfg.configFile;

    environment.systemPackages = [ pkgs.i3status ];
  };
}
