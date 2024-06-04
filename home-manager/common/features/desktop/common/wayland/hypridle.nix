{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on"; # turn on display after resume.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        lock_cmd = "pidof hyprlock || hyprlock"; # lock screen.
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session"; # lock screen.
        }

        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off"; # turn off display.
          on-resume = "hyprctl dispatch dpms on"; # turn on display.
        }

        {
          timeout = 600;
          on-timeout = "systemctl suspend"; # suspend.
        }
      ];
    };
  };
}
