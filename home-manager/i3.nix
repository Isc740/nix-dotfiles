{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
  # colors = {
  #   background = "#282a36";
  #   focused = "#bd93f9";
  #   unfocused = "#44475a";
  #   urgent = "#ff5555";
  # };
in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = {
      modifier = mod;
      gaps = {
        inner = 8;
        outer = 5;
      };

      window = {
        border = 2;
        titlebar = false;
      };

      # fonts = [ "Iosevka" ];

      keybindings = lib.mkOptionDefault {
        "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+Shift+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${mod}+Shift+q" = "kill";

        #FOCUS
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus up";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus right";

        #MOVE
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move up";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move left";

        "${mod}+t" = "floating toggle";

        "${mod}+Shift+r" = "reload";
      };

      bars = [{ 
        position = "top";
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
      }];
    };
  };

}
