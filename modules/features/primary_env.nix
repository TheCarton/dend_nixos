{ self, ... }:
{
  flake.nixosModules.primaryEnv =
    { pkgs, ... }:
    let
      selfpkgs = self.packages."${pkgs.system}";
    in
    {
      programs.niri.enable = true;
      programs.niri.package = selfpkgs.niri;

      environment.variables = {
        EDITOR = "hx";
      };

      imports = [
        self.nixosModules.niri
        self.nixosModules.yazi
        self.nixosModules.sddm
      ];

      environment.systemPackages = [
        pkgs.lazygit
        selfpkgs.noctalia-shell
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
