{
  flake.nixosModules.gdm =
    { pkgs, ... }:
    {
      services.displayManager.gdm = {
        enable = true;
        autoSuspend = false; # does suspend work?
      };
      programs.uwsm.waylandCompositors = {
        prettyName = "Niri";
        comment = "Niri compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/niri";
      };
    };
}
