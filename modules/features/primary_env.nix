{ self, ... }:
{
  flake.nixosModules.primaryEnv =
    { pkgs, inputs, ... }:
    let
      selfpkgs = self.packages."${pkgs.system}";
    in
    {

      environment.variables = {
        EDITOR = "hx";
      };

      imports = [
        self.nixosModules.niri
        self.nixosModules.sddm
        self.nixosModules.noctalia
        self.nixosModules.yazi
        self.nixosModules.terminal
        self.nixosModules.helixExtras
        self.nixosModules.cursorClip
      ];

      environment.systemPackages = [
        pkgs.chezmoi
        selfpkgs.wrapped-helix
        selfpkgs.fish
        selfpkgs.kitty
        selfpkgs.nh
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        ubuntu-sans
        cm_unicode
        corefonts
        unifont
      ];

      fonts.fontconfig.defaultFonts = {
        serif = [ "Ubuntu Sans" ];
        sansSerif = [ "Ubuntu Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
}
