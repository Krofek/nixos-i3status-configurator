{
  "wireless _first_" = {
    format_up = "W: (%quality at %essid) %ip";
    format_down = "W: down";
  };

  "ethernet _first_"  = {
    # if you use %speed, i3status requires root privileges
    format_up = "E: %ip (%speed)";
    format_down = "E: down";
  };

  "battery all" = {
    format = "%status %percentage %remaining";
  };

  "tztime local" = {
    format = "%Y-%m-%d %H:%M:%S";
  };

  "load" = {
    format = "%1min";
  };

  "disk \"/\"" = {
    format = "%avail";
  };

  "cpu_temperature 0" = {
    format = "T: %degrees °C";
    path = "/sys/devices/platform/thinkpad_hwmon/temp1_input";
  };

}
