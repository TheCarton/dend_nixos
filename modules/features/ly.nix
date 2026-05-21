{ self, inputs, ... }:
{
  flake.nixosModules.ly =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        cmatrix
      ];
      services.displayManager.ly.enable = true;
      services.displayManager.ly.settings = {
        animation = "doom";
        clear_password = true;
      };
    };
}
