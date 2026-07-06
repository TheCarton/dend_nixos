{ self, inputs, ... }:
{
  flake.nixosModules.primaryEnv =
    { pkgs, ... }:
    let
      selfpkgs = self.packages."${pkgs.system}";
    in
    {

      users.defaultUserShell = pkgs.fish;

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.luke = {
        isNormalUser = true;
        description = "luke";
        extraGroups = [
          "networkmanager"
          "wheel"
          "audio"
          "fuse" # needed for sshfs
        ];
      };

      environment.variables = {
        EDITOR = "hx";
      };

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };

      services.syncthing = {
        enable = true;
        user = "luke";
        group = "users";
        dataDir = "/home/luke"; # where syncthing stores its state
        configDir = "/home/luke/.config/syncthing";
        openDefaultPorts = true;
      };

      programs.fish.enable = true;
      imports = [
        self.nixosModules.niri
        self.nixosModules.ly
        self.nixosModules.noctalia
        self.nixosModules.yazi
        self.nixosModules.terminal
        self.nixosModules.helixExtras
      ];

      ## Add software below.
      environment.systemPackages = [
        pkgs.kdePackages.okular
        pkgs.qbittorrent
        pkgs.libreoffice
        pkgs.mpv
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        pkgs.anki
        pkgs.keepassxc
        pkgs.sshfs
        pkgs.chezmoi
        pkgs.kitty
        pkgs.signal-desktop
        pkgs.discord
        pkgs.super-productivity
        selfpkgs.wrapped-helix
        selfpkgs.nh
      ];

      programs.localsend.enable = true;
      programs.localsend.openFirewall = true;

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
