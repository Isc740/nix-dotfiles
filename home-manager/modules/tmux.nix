{ pkgs, ... }:
let
  # tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin {
  #   pluginName = "tmux-super-fingers";
  #   version = "unstable-2023-01-06";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "artemave";
  #     repo = "tmux_super_fingers";
  #     rev = "2c12044984124e74e21a5a87d00f844083e4bdf7";
  #     sha256 = "sha256-cPZCV8xk9QpU49/7H8iGhQYK6JwWjviL29eWabuqruc=";
  #   };
  # };
in
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      pkgs.tmuxPlugins.vim-tmux-navigator
      # {
      #   plugin = tmux-super-fingers;
      #   extraConfig = "set -g @super-fingers-key f";
      # }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];

    extraConfig = '''';
  };
}
