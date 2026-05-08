{ self, ... }:
{
  flake.nixosModules.primaryEnv =
    { pkgs, inputs, ... }:
    let
      selfpkgs = self.packages."${pkgs.system}";
    in
    {

      users.defaultUserShell = pkgs.fish;

      environment.variables = {
        EDITOR = "hx";
      };

      programs.fish.enable = true;
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
        pkgs.kitty
        pkgs.signal-desktop
        selfpkgs.wrapped-helix
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
