{ self, inputs, ... }: {
  perSystem = { pkgs, lib, self', ... }: {
    packages.kitty= inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      settings = {
        font_size = 15;
        font_family = "JetBrainsMono Nerd Font";
        shell_integration = "enabled";
        shell = lib.getExe self'.packages.fish;
        
    };

    };
  };
}
