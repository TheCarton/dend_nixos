{ self, inputs, ... }:
{
  flake.nixosModules.virt =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        # virt-manager
        dnsmasq
      ];
      networking.firewall.trustedInterfaces = [ "virbr0" ];
      # this needs to be run:
      # virsh net-autostart default

      virtualisation.libvirtd.enable = true;
      programs.virt-manager.enable = true;
      virtualisation.libvirtd.qemu.swtpm.enable = true;
      users.users.luke.extraGroups = [ "libvirtd" ];
    };
}
