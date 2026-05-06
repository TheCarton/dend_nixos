# create terminal features e.g zoxide, ripgrep, github helper, htop
# fzf?
{
  flake.nixosModules.terminal =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.lazygit
        pkgs.gh
        pkgs.ripgrep
        pkgs.fzf
        pkgs.htop
        pkgs.rip2
        pkgs.zip
        pkgs.unzip
      ];
    };
}
