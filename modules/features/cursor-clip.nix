{ self, inputs, ... }:
{
  flake.nixosModules.cursorClip =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = [
        pkgs.cursor-clip
      ];
    };
}
