{
  flake.nixosModules.sddm =
    { pkgs, ... }:
    {
      qt.enable = true;
      services.displayManager = {
        # generic.preStart = "${pkgs.wlr-randr}/bin/wlr-randr --output HDMI-A-1 --off";
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
        pkgs.wlr-randr
        pkgs.sddm-astronaut
      ];

    };
}
