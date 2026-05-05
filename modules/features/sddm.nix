{ self, ... }:

{
  flake.nixosModules.sddm =
    { pkgs, ... }:
    {
      services.displayManager.sddm = {
        enable = true;
        theme = "catppuccin-mocha-mauve";
        wayland = {
          enable = true;
        };
        autoNumlock = true;
        enableHidpi = true;
      };
      environment.systemPackages = [
        # (pkgs.catppuccin-sddm.override {
        #   flavor = "mocha";
        #   accent = "mauve";
        # })
      ];
    };
}
