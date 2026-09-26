{ osConfig, lib, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
    };
  };

  xdg.configFile."niri/config.kdl" = lib.mkIf osConfig.programs.niri.enable {
    source = ../../dotfiles/niri/noctalia-niri-config.kdl;
  };
}
