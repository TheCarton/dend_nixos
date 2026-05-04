{ self, inputs, ... }: {
flake.nixosModules.yazi =
    { pkgs, lib, ... }:
    {
      programs.yazi = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.wrapped-yazi;
      };
    };

    perSystem = { pkgs, ... }: {
    packages.wrapped-yazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      flavors = {
        dark = "gruvbox-dark";
      };
    };
      
    };
}
