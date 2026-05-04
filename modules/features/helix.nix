{ self, inputs, ... }:
{
  # flake.nixosModules.helix =
  #   { pkgs, lib, ... }:
  #   {
  #     environment.systemPackages = [
  #       self'.packages.wrapped-helix
  #     ];
  #   };
  #
  # I'm confused how to installed wrapped-helix system-wide. Helix doesn't have
  # an options.enable like niri does
  # I could try to rip off vimjoyer's whole enviornment.nix file, which seems
  # to accomplish this with the self' variable
  # https://github.com/vimjoyer/nixconf/blob/main/wrappedPrograms/environment.nix 

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.wrapped-helix = inputs.wrapper-modules.wrappers.helix.wrap {
        inherit pkgs;
        settings = {
          theme = "tokyonight";
        };
    };
};
}
