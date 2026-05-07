{ self, inputs, ... }:
{
  flake.nixosModules.noctalia =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.noctalia-shell
      ];
    };
}
