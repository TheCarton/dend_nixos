{ self, inputs, ... }:
{
  flake.nixosModules.laptopConfiguration =

    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      programs.nano.enable = false;
      imports = [
        self.nixosModules.laptopHardware
        self.nixosModules.primaryEnv
        self.nixosModules.nix
      ];

      fonts.fontDir.enable = true;

      hardware.openrazer = {
        enable = true;
      };

      # following nixos wiki at https://nixos.wiki/wiki/VirtualBox
      users.extraGroups.vboxusers.members = [ "luke" ];
      # installed software
      environment.systemPackages = with pkgs; [
        vim
        firefox
        git
        _1password-gui
        evremap
      ];

      # services = {
      #   evdevremapkeys = {
      #     enable = true;
      #     settings = {
      #       devices = [
      #         {
      #           input_name = "Logitech USB Keyboard";
      #           output_name = "remap-capslock";
      #           remappings = {
      #             KEY_CAPSLOCK = [ "KEY_LEFTMETA" ];
      #           };
      #         }
      #       ];
      #     };
      #   };
      # };

      # Clean up Nix store entries that are older than 30 days.
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      # Enable OpenGL
      hardware.graphics = {
        enable = true;
      };

      environment.sessionVariables = {
        # Hint Electon apps to use wayland
        NIXOS_OZONE_WL = "1";
      };

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "laptop"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;

      # Set your time zone.
      time.timeZone = "America/New_York";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

      # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true; # if not already enabled
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment the following
        #jack.enable = true;
      };

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.luke = {
        isNormalUser = true;
        description = "luke";
        extraGroups = [
          "networkmanager"
          "wheel"
          "openrazer" # needed for openrazer-daemon
          "audio"
        ];
      };

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      services.gvfs.enable = true;
      services.udisks2.enable = true;

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          X11Forwarding = true;
        };
      };

      # To mess with firewall rules temporarily
      # use nixos-firewall-tool
      networking.firewall.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?
    };
}
