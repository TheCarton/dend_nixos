{
  flake.nixosModules.sddm =
    { pkgs, ... }:
    {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
}
