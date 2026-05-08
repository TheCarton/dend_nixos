{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      programs.niri.enable = true;
      environment.systemPackages = with pkgs; [
        xwayland-satellite
        mako
        wlr-which-key
      ];

      security.polkit.enable = true; # polkit
      services.gnome.gnome-keyring.enable = true; # secret service
      security.pam.services.swaylock = { };

      # NixOS otherwise injects a stripped PATH via Environment= on the niri.service
      # unit which shadows the imported user-manager PATH. Disabling the default
      # lets niri inherit the full PATH set up by niri-session.
      systemd.user.services.niri.enableDefaultPath = false;
    };
}
