{ pkgs, ...}:
let
  user = "sjcobb";
  greetd = "${pkgs.greetd.greetd}/bin/greetd";
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --cmd Hyprland";
        inherit user;
      };
      initial_session = {
        command = "$SHELL -l";
        inherit user;
      };
    };
  };
  environment.etc."greetd/environments".text = ''
    Hyprland
    fish
    bash
  '';
}
