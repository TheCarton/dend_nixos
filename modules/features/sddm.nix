{
  flake.nixosModules.sddm =
    { pkgs, ... }:
    {
      qt.enable = true;
      services.displayManager = {
        sddm = {
          package = pkgs.kdePackages.sddm;
          enable = true;
          wayland.enable = true;
          autoNumlock = true;
          theme = "sddm-astronaut-theme";
          extraPackages = [ pkgs.sddm-astronaut ];
        };
        defaultSession = "niri";
      };

      environment.systemPackages = [
        pkgs.kdePackages.qtmultimedia
        pkgs.sddm-astronaut
      ];

    };
}
