{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    {
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.noctalia-shell)
          ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input.keyboard.xkb.layout = "us,ua";

          layout.gaps = 5;

          binds = {
            "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
            "Mod+W".close-window = {};
            "Mod+space".spawn-sh = "${lib.getExe self'.packages.noctalia-shell} ipc call launcher toggle";

            "Mod+F".maximize-column = {};
            "Mod+G".fullscreen-window = {};
            "Mod+Shift+F".toggle-window-floating = {};
            "Mod+C".center-column = {};

            "Mod+H".focus-column-left = {};
            "Mod+L".focus-column-right = {};
            "Mod+K".focus-window-up = {};
            "Mod+J".focus-window-down = {};

            "Mod+Left".focus-column-left = {};
            "Mod+Right".focus-column-right = {};
            "Mod+Up".focus-window-up = {};
            "Mod+Down".focus-window-down = {};

            "Mod+Shift+H".move-column-left = {};
            "Mod+Shift+L".move-column-right = {};
            "Mod+Shift+K".move-window-up = {};
            "Mod+Shift+J".move-window-down = {};

            "Mod+1".focus-workspace = "w0";
            "Mod+2".focus-workspace = "w1";
            "Mod+3".focus-workspace = "w2";
            "Mod+4".focus-workspace = "w3";
            "Mod+5".focus-workspace = "w4";
            "Mod+6".focus-workspace = "w5";
            "Mod+7".focus-workspace = "w6";
            "Mod+8".focus-workspace = "w7";
            "Mod+9".focus-workspace = "w8";
            "Mod+0".focus-workspace = "w9";

            "Mod+Shift+1".move-column-to-workspace = "w0";
            "Mod+Shift+2".move-column-to-workspace = "w1";
            "Mod+Shift+3".move-column-to-workspace = "w2";
            "Mod+Shift+4".move-column-to-workspace = "w3";
            "Mod+Shift+5".move-column-to-workspace = "w4";
            "Mod+Shift+6".move-column-to-workspace = "w5";
            "Mod+Shift+7".move-column-to-workspace = "w6";
            "Mod+Shift+8".move-column-to-workspace = "w7";
            "Mod+Shift+9".move-column-to-workspace = "w8";
            "Mod+Shift+0".move-column-to-workspace = "w9";
            
          };
        };
      };
    };
}
