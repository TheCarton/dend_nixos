{ self, inputs, ... }:
{
  # flake.nixosModules.helix =
  #   { pkgs, lib, ... }:
  #   {
  #     environment.systemPackages = [
  #       self'.packages.wrapped-helix
  #     ];
  #   };
  #
  # I'm confused how to installed wrapped-helix system-wide. Helix doesn't have
  # an options.enable like niri does
  # I could try to rip off vimjoyer's whole enviornment.nix file, which seems
  # to accomplish this with the self' variable
  # https://github.com/vimjoyer/nixconf/blob/main/wrappedPrograms/environment.nix

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.wrapped-helix = inputs.wrapper-modules.wrappers.helix.wrap {
        inherit pkgs;
        settings = {
          keys.normal = {
            space."1" = ":w";
            space.q = ":q";
          };

          editor = {
            soft-wrap.enable = true;
            soft-wrap.wrap-indicator = "";
            line-number = "relative";
            text-width = 80;
            soft-wrap.wrap-at-text-width = true;

            cursor-shape.insert = "bar";
            cursor-shape.select = "underline";
            lsp = {
              auto-signature-help = false;
              display-messages = true;
            };
          };

          theme = "gruvbox";
        };
        languages = {
          language-server.godot = {
            command = "nc";
            args = [
              "127.0.0.1"
              "6005"
            ];

          };

          language-server.rust-analyzer.config.check.command = "clippy";

          language-server.mpls = {
            command = "mpls";
            args = [
              "--dark-mode"
              "--enable-emoji"
            ];
          };

          language = [
            {
              name = "gdscript";
              language-servers = [ "godot" ];
            }

            {
              name = "nix";
              auto-format = true;
              formatter = {
                command = "nixfmt";
              };
            }
            {
              name = "rust";
              auto-format = true;
              formatter = {
                command = "rustfmt";
              };
            }
            {
              name = "markdown";
              auto-format = true;
              language-servers = [
                "marksman"
                "ltex-ls-plus"
                "mpls"
              ];
              formatter = {
                command = "prettierd";
                args = [
                  "--parser"
                  "markdown"
                  "--prose-wrap"
                  "never" # <always|never|preserve>
                ];
              };

            }
          ];
        };
      };
    };
}
